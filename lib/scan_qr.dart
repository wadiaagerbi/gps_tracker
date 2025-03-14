import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gps_tracker/tracking_page.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  ScanQRPageState createState() => ScanQRPageState();
}

class ScanQRPageState extends State<ScanQRPage> {
  String? transporterId;

  void _onQRScanned(String id) {
    setState(() {
      transporterId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Transporter QR')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (capture) {
                for (final barcode in capture.barcodes) {
                  if (barcode.rawValue != null) {
                    _onQRScanned(barcode.rawValue!);
                  }
                }
              },
            ),
          ),
          if (transporterId != null) ...[
            const SizedBox(height: 20),
            Text("Transporter ID: $transporterId", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
          ],
          ElevatedButton.icon(
            icon: const Icon(Icons.location_searching),
            label: const Text('Start Tracking'),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => TrackingPage(transporterId: transporterId ?? "unknown"),
                  transitionsBuilder: (_, animation, __, child) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
