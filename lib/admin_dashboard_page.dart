import 'package:flutter/material.dart';
import 'package:gps_tracker/admin_shipment_details_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de bord - Administrateur',
          style: TextStyle(color: Colors.black87), // Force dark text
        ),
        backgroundColor: const Color(0xFFFCC236), // Your brand color
        iconTheme: const IconThemeData(color: Colors.black87), // Dark icons
        elevation: 0,
      ),
      backgroundColor: Colors.white, // Force light background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expéditions en cours",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Force dark text
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    elevation: 1,
                    child: ListTile(
                      title: const Text("Expédition #123"),
                      subtitle: const Text("Statut: En transit"),
                      trailing: const Icon(Icons.arrow_forward, color: Color(0xFFFCC236)),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminShipmentDetailsPage(shipmentId: "123"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 1,
                    child: ListTile(
                      title: const Text("Expédition #456"),
                      subtitle: const Text("Statut: Retard", style: TextStyle(color: Colors.red)),
                      trailing: const Icon(Icons.arrow_forward, color: Color(0xFFFCC236)),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminShipmentDetailsPage(shipmentId: "456"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 1,
                    child: ListTile(
                      title: const Text("Expédition #789"),
                      subtitle: const Text("Statut: Livré", style: TextStyle(color: Colors.green)),
                      trailing: const Icon(Icons.arrow_forward, color: Color(0xFFFCC236)),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminShipmentDetailsPage(shipmentId: "789"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Indicateurs clés",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Force dark text
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "85%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFCC236), // Your brand color
                          ),
                        ),
                        const Text("Livraisons à temps"),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.grey[300],
                    ),
                    Column(
                      children: [
                        const Text(
                          "15%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const Text("Retards"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
