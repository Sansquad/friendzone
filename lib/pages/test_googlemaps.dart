import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestMapPage extends StatefulWidget {
  @override
  TestMapPageState createState() => TestMapPageState();
}

class TestMapPageState extends State<TestMapPage> {
  
  // initial position of the camera
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 13.5,
  );

  GoogleMapController? _googleMapController;

  // initial position marker
  Marker _origin = Marker(
    markerId: MarkerId('current_position'),
    position: _initialCameraPosition.target,
    infoWindow: InfoWindow(title: 'Current Location'),
  );

  /////////////////////////////

  final Set<Polyline> _gridLines = {};
  
  // long lat lines
  void _createGrid() {
    // Define the latitude and longitude range for the grid over the US
    double minLat = 24.396308;  // Southernmost point in the continental US
    double maxLat = 49.384358;  // Northernmost point in the continental US
    double minLng = -125.0;     // Westernmost point in the continental US
    double maxLng = -66.93457;  // Easternmost point in the continental US
    double gridSpacing = 0.0145;   // 1 degree is approximately 69 miles -> 0.0145 degrees is approximately 1 mile

    // Create horizontal grid lines (constant latitude)
    for (double lat = minLat; lat <= maxLat; lat += gridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lat_$lat'),
          points: [
            LatLng(lat, minLng),
            LatLng(lat, maxLng),
          ],
          color: Colors.blue,
          width: 1,
        ),
      );
    }

    // Create vertical grid lines (constant longitude)
    for (double lng = minLng; lng <= maxLng; lng += gridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lng_$lng'),
          points: [
            LatLng(minLat, lng),
            LatLng(maxLat, lng),
          ],
          color: Colors.blue,
          width: 1,
        ),
      );
    }
  }

  ////////////////////////////

  @override
  void initState() {
    super.initState();
    _createGrid();
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // Set the background color of the page
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface, // Use the theme's surface color
        title: Text('Test Map Page'),
        centerTitle: true, // Center the title if desired
        automaticallyImplyLeading: false, // This removes the default back button
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary), // Use "X" icon with white color
            onPressed: () {
              Navigator.pushNamed(context, '/contentlayout');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 130),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to Friend',
                      style: TextStyle(
                        fontFamily: 'BigShouldersText',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'zone',
                      style: TextStyle(
                        fontFamily: 'BigShouldersText',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              ///////// GOOGLE MAPS IMPLEMENTATION ////////
              //////////// 2024 - 08 - 17 /////////////////
              
              Container(
                height: 300,
                width: 300,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (controller) => _googleMapController = controller,
                  markers: { _origin },
                  polylines: _gridLines,
                  
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use the color of the text on the primary color
        onPressed: () => _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}

