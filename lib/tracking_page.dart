import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'shipment_notifications_page.dart';
import 'shipment_history_page.dart';

class TrackingPage extends StatefulWidget {
  final String transporterId;

  const TrackingPage({super.key, required this.transporterId});

  @override
  TrackingPageState createState() => TrackingPageState();
}

class TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  LatLng _transporterLocation = const LatLng(37.7749, -122.4194); // Default location
  String shipmentStatus = "Picked Up";

  @override
  void initState() {
    super.initState();
    _simulateTracking();
  }

  void _simulateTracking() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _transporterLocation = const LatLng(37.7849, -122.4294);
        shipmentStatus = "In Transit";
        _mapController?.animateCamera(CameraUpdate.newLatLng(_transporterLocation));
      });
    });

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        _transporterLocation = const LatLng(37.7949, -122.4394);
        shipmentStatus = "Delivered";
        _mapController?.animateCamera(CameraUpdate.newLatLng(_transporterLocation));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Transporter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShipmentNotificationsPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ShipmentHistoryPage()));
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _transporterLocation, zoom: 15),
        markers: {Marker(markerId: const MarkerId("transporter"), position: _transporterLocation)},
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
