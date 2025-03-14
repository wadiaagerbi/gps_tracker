import 'package:flutter/material.dart';

class ShipmentNotificationsPage extends StatelessWidget {
  const ShipmentNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notifications = [
      "Package Picked Up ✅",
      "Arrived at Warehouse 🏢",
      "Out for Delivery 🚚",
      "Delivered 📦"
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Shipment Notifications')),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.deepPurple),
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}
