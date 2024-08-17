import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestMapPage extends StatefulWidget {
  const TestMapPage({super.key});

  @override
  State<TestMapPage> createState() => TestMapPageState();
}

class TestMapPageState extends State<TestMapPage> {
  static const LatLng defaultLocation = LatLng(37.4223, -122.0848);
  GoogleMapController? _controller;
  Position? _currentPosition;
  String _currentZone = "C-197";
  int _activeUsers = 224;
  List<Polyline> _gridLines = [];
  List<Polygon> _shadedGrids = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Map Page'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: defaultLocation,
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}