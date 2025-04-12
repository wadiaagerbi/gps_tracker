import 'package:flutter/material.dart';

class ShipmentHistoryPage extends StatelessWidget {
  const ShipmentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> history = [
      {
        "date": "1 Mars 2025",
        "status": "Livré",
        "details": "Colis remis au client",
        "icon": Icons.check_circle,
        "color": Colors.green
      },
      {
        "date": "2 Mars 2025",
        "status": "En Transit",
        "details": "Dernière position: Entrepôt Lyon",
        "icon": Icons.local_shipping,
        "color": Colors.orange
      },
      {
        "date": "3 Mars 2025",
        "status": "Collecté",
        "details": "Colis pris en charge par le transporteur",
        "icon": Icons.inventory,
        "color": Colors.blue
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historique des Expéditions',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFCC236),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher dans l\'historique...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: history.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey[200]!),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item["color"].withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item["icon"], color: item["color"]),
                    ),
                    title: Text(
                      item["status"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["details"]),
                        const SizedBox(height: 4),
                        Text(
                          item["date"],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                    onTap: () {
                      // Handle item tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Export history functionality
        },
        backgroundColor: const Color(0xFFFCC236),
        child: const Icon(Icons.download, color: Colors.white),
      ),
    );
  }
}