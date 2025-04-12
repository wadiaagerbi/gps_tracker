import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ActivateTrackingPage extends StatefulWidget {
  const ActivateTrackingPage({super.key});

  @override
  ActivateTrackingPageState createState() => ActivateTrackingPageState();
}

class ActivateTrackingPageState extends State<ActivateTrackingPage> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  bool _isTracking = false;
  final List<Marker> _checkpoints = [];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez activer les services de localisation.')), // Translated
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Les permissions de localisation sont refusées.')), // Translated
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les permissions de localisation sont définitivement refusées.')), // Translated
      );
      return;
    }

    _startTracking();
  }

  void _startTracking() {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
      });
    });
  }

  void _markCheckpoint() {
    if (_currentLocation != null) {
      setState(() {
        _checkpoints.add(Marker(
          markerId: MarkerId("checkpoint_${_checkpoints.length}"),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: "Point de contrôle"), // Translated
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activation du suivi', style: TextStyle(color: Colors.black87)), // Translated
        backgroundColor: const Color(0xFFFCC236), // Your brand color
        iconTheme: const IconThemeData(color: Colors.black87), // Dark icons
        elevation: 0,
      ),
      backgroundColor: Colors.white, // Force light background
      body: Stack(
        children: [
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: _currentLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                      infoWindow: const InfoWindow(title: "Votre position"), // Translated
                    ),
                    ..._checkpoints,
                  },
                  onMapCreated: (controller) => _mapController = controller,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow, color: Colors.white),
                    label: Text(
                      _isTracking ? 'Arrêter le suivi' : 'Démarrer le suivi', // Translated
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCC236), // Your brand color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isTracking = !_isTracking;
                        if (_isTracking) _startTracking();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.flag, color: Colors.white),
                    label: const Text(
                      'Marquer un point', // Translated
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCC236), // Your brand color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _markCheckpoint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}