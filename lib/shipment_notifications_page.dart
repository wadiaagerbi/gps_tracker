import 'package:flutter/material.dart';

class ShipmentNotificationsPage extends StatelessWidget {
  const ShipmentNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Colis pris en charge",
        "details": "Votre colis #12345 a été pris en charge par le transporteur",
        "time": "Aujourd'hui, 09:30",
        "icon": Icons.check_circle,
        "color": Colors.green,
        "read": false
      },
      {
        "title": "Arrivé à l'entrepôt",
        "details": "Votre colis est arrivé à notre centre de tri à Lyon",
        "time": "Hier, 14:15",
        "icon": Icons.warehouse,
        "color": Colors.blue,
        "read": true
      },
      {
        "title": "En cours de livraison",
        "details": "Votre colis est en route vers votre adresse",
        "time": "Hier, 08:45",
        "icon": Icons.local_shipping,
        "color": const Color(0xFFFCC236),
        "read": true
      },
      {
        "title": "Livré avec succès",
        "details": "Votre colis a été livré à l'adresse indiquée",
        "time": "15 Mars 2025, 11:20",
        "icon": Icons.assignment_turned_in,
        "color": Colors.purple,
        "read": true
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications d\'Expédition',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFCC236),
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${notifications.where((n) => !n["read"]).length} nouvelles notifications',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Mark all as read functionality
                  },
                  child: const Text(
                    'Tout marquer comme lu',
                    style: TextStyle(color: Color(0xFFFCC236)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  color: notification["read"] ? Colors.white : Colors.grey[50],
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: notification["color"].withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification["icon"],
                        color: notification["color"],
                      ),
                    ),
                    title: Text(
                      notification["title"],
                      style: TextStyle(
                        fontWeight: notification["read"] ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification["details"]),
                        const SizedBox(height: 4),
                        Text(
                          notification["time"],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: !notification["read"]
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCC236),
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                    onTap: () {
                      // Handle notification tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}