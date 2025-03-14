import 'package:flutter/material.dart';

class ShipmentHistoryPage extends StatelessWidget {
  const ShipmentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> history = [
      {"date": "March 1, 2025", "status": "Delivered"},
      {"date": "March 2, 2025", "status": "In Transit"},
      {"date": "March 3, 2025", "status": "Picked Up"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Shipment History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history, color: Colors.deepPurple),
            title: Text(history[index]["status"]!),
            subtitle: Text(history[index]["date"]!),
          );
        },
      ),
    );
  }
}
