import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  static const googlePlex = LatLng(37.4223, -122.0848);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: googlePlex,
          zoom:13,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('SourceLocation'),
            icon:BitmapDescriptor.defaultMarker,
            position: googlePlex,
            ),
        },
     )
  );
}