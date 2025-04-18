import 'package:flutter/material.dart';
import 'package:gps_tracker/scan_qr.dart';
import 'package:gps_tracker/tracking_page.dart';
import 'package:gps_tracker/shipment_notifications_page.dart';
import 'package:gps_tracker/shipment_history_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NeoTrack - Accueil')), // Translated
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),

            // Scan QR Code Button
            ElevatedButton.icon(
              icon: const Icon(Icons.qr_code),
              label: const Text('Scanner QR Code'), // Translated
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: const Color(0xFFFCC236), // Your chart color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanQRPage()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Track GPS Button
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Suivre l\'expédition'), // Translated
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: const Color(0xFFFCC236), // Your chart color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackingPage(transporterId: "1")),
                );
              },
            ),
            const SizedBox(height: 20),

            // View Notifications Button
            ElevatedButton.icon(
              icon: const Icon(Icons.notifications),
              label: const Text('Voir les notifications'), // Translated
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: const Color(0xFFFCC236), // Your chart color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShipmentNotificationsPage()),
                );
              },
            ),
            const SizedBox(height: 20),

            // View History Button
            ElevatedButton.icon(
              icon: const Icon(Icons.history),
              label: const Text('Historique des expéditions'), // Translated
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                backgroundColor: const Color(0xFFFCC236), // Your chart color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShipmentHistoryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}