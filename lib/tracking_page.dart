import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_tracker/shipment_notifications_page.dart';
import 'package:gps_tracker/shipment_history_page.dart';

class TrackingPage extends StatefulWidget {
  final String transporterId;

  const TrackingPage({super.key, required this.transporterId});

  @override
  TrackingPageState createState() => TrackingPageState();
}

class TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  LatLng _transporterLocation = const LatLng(37.7749, -122.4194);
  String _shipmentStatus = "Collecté";
  bool _isDelayed = false;

  @override
  void initState() {
    super.initState();
    _simulateTracking();
  }

  void _simulateTracking() {
    // Initial update after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _transporterLocation = const LatLng(37.7849, -122.4294);
        _shipmentStatus = "En Transit";
        _isDelayed = true;
        _mapController?.animateCamera(CameraUpdate.newLatLng(_transporterLocation));
      });
    });

    // Final update after 8 seconds
    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        _transporterLocation = const LatLng(37.7949, -122.4394);
        _shipmentStatus = "Livré";
        _isDelayed = false;
        _mapController?.animateCamera(CameraUpdate.newLatLng(_transporterLocation));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suivi #${widget.transporterId}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFFFCC236),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: true,
              backgroundColor: Colors.red,
              child: const Icon(Icons.notifications),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShipmentNotificationsPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShipmentHistoryPage(),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _transporterLocation,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("transporter"),
                position: _transporterLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  _isDelayed 
                    ? BitmapDescriptor.hueOrange
                    : BitmapDescriptor.hueGreen,
                ),
                infoWindow: InfoWindow(
                  title: "Statut: $_shipmentStatus",
                  snippet: "ID: ${widget.transporterId}",
                ),
              ),
            },
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
          ),

          // Status overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      _isDelayed ? Icons.warning : Icons.check_circle,
                      color: _isDelayed ? Colors.orange : Colors.green,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _shipmentStatus,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _isDelayed 
                              ? "Retard détecté - Intervention recommandée"
                              : "Dernière mise à jour: ${TimeOfDay.now().format(context)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom action bar
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: 'refresh',
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () => _simulateTracking(),
                  child: const Icon(Icons.refresh, color: Colors.black87),
                ),
                const Spacer(),
                FloatingActionButton.extended(
                  heroTag: 'intervene',
                  icon: const Icon(Icons.warning, color: Colors.white),
                  label: const Text(
                    'Intervenir',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFFCC236),
                  onPressed: () {
                    // Intervention logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}