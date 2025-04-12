import 'package:flutter/material.dart';
import 'package:gps_tracker/tracking_page.dart';
import 'package:gps_tracker/activate_tracking_page.dart';

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
      appBar: AppBar(
        title: const Text(
          'Scanner QR Transporteur',
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCC236).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color(0xFFFCC236),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      size: 80,
                      color: Color(0xFFFCC236),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Scannez le QR code du transporteur",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Placez le code QR dans le cadre pour le scanner",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code, color: Colors.white),
                      label: const Text(
                        'Simuler Scan',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFCC236),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _onQRScanned("12345"); // Example transporterId
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    icon: const Icon(Icons.location_on),
                    label: const Text('Activer le suivi manuellement'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ActivateTrackingPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (transporterId != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    "Transporteur scanné",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "ID: $transporterId",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.location_searching, color: Colors.white),
                      label: const Text(
                        'Voir la position',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFCC236),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingPage(transporterId: transporterId!),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}