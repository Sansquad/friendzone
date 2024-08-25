// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class TestMapPage extends StatefulWidget {
//   @override
//   TestMapPageState createState() => TestMapPageState();
// }

// class TestMapPageState extends State<TestMapPage> {
  
//   // initial position of the camera
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(37.773972, -122.431297),
//     zoom: 11.5,
//   );

//   GoogleMapController? _googleMapController;

//   // initial position marker
//   Marker _origin = Marker(
//     markerId: MarkerId('current_position'),
//     position: _initialCameraPosition.target,
//     infoWindow: InfoWindow(title: 'Current Location'),
//   );

//   /////////////////////////////

//   final Set<Polyline> _gridLines = {};
  
//   // long lat lines
//   void _createGrid() {
//     // Define the latitude and longitude range for the grid over the US
//     double minLat = 24.396308;  // Southernmost point in the continental US
//     double maxLat = 49.384358;  // Northernmost point in the continental US
//     double minLng = -125.0;     // Westernmost point in the continental US
//     double maxLng = -66.93457;  // Easternmost point in the continental US
//     double lnggridSpacing = 0.0145;   // 1 degree is approximately 69 miles -> 0.0145 degrees is approximately 1 mile
//     double latgridSpacing = 0.012;   // 

//     // Create horizontal grid lines (constant latitude)
//     for (double lat = minLat; lat <= maxLat; lat += latgridSpacing) {
//       _gridLines.add(
//         Polyline(
//           polylineId: PolylineId('lat_$lat'),
//           points: [
//             LatLng(lat, minLng),
//             LatLng(lat, maxLng),
//           ],
//           color: Colors.blue,
//           width: 1,
//         ),
//       );
//     }

//     // Create vertical grid lines (constant longitude)
//     for (double lng = minLng; lng <= maxLng; lng += lnggridSpacing) {
//       _gridLines.add(
//         Polyline(
//           polylineId: PolylineId('lng_$lng'),
//           points: [
//             LatLng(minLat, lng),
//             LatLng(maxLat, lng),
//           ],
//           color: Colors.blue,
//           width: 1,
//         ),
//       );
//     }
//   }

//   ////////////////////////////

//   @override
//   void initState() {
//     super.initState();
//     _createGrid();
//   }

//   @override
//   void dispose() {
//     _googleMapController!.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface, // Set the background color of the page
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.surface, // Use the theme's surface color
//         title: Text('Test Map Page'),
//         centerTitle: true, // Center the title if desired
//         automaticallyImplyLeading: false, // This removes the default back button
//         actions: [
//           IconButton(
//             icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary), // Use "X" icon with white color
//             onPressed: () {
//               Navigator.pushNamed(context, '/contentlayout');
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 130),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: 'Welcome to Friend',
//                       style: TextStyle(
//                         fontFamily: 'BigShouldersText',
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'zone',
//                       style: TextStyle(
//                         fontFamily: 'BigShouldersText',
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),

//               ///////// GOOGLE MAPS IMPLEMENTATION ////////
//               //////////// 2024 - 08 - 17 /////////////////
              
//               Container(
//                 height: 300,
//                 width: 300,
//                 child: GoogleMap(
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: true,
//                   initialCameraPosition: _initialCameraPosition,
//                   onMapCreated: (controller) => _googleMapController = controller,
//                   markers: { _origin },
//                   polylines: _gridLines,
                  
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use the color of the text on the primary color
//         onPressed: () => _googleMapController?.animateCamera(
//           CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: const Icon(Icons.center_focus_strong),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestMapPage extends StatefulWidget {
  @override
  TestMapPageState createState() => TestMapPageState();
}

class TestMapPageState extends State<TestMapPage> {
  
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 13.5,
  );

  GoogleMapController? _googleMapController;

  Marker _origin = Marker(
    markerId: MarkerId('current_position'),
    position: _initialCameraPosition.target,
    infoWindow: InfoWindow(title: 'Current Location'),
  );

  final Set<Polyline> _gridLines = {};

  void _createGrid(LatLngBounds bounds) {
    _gridLines.clear();

    double minLat = bounds.southwest.latitude;
    double maxLat = bounds.northeast.latitude;
    double minLng = bounds.southwest.longitude;
    double maxLng = bounds.northeast.longitude;
    double lnggridSpacing = 0.0145;
    double latgridSpacing = 0.012;

    for (double lat = (minLat ~/ latgridSpacing) * latgridSpacing; lat <= maxLat; lat += latgridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lat_$lat'),
          points: [
            LatLng(lat, minLng),
            LatLng(lat, maxLng),
          ],
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      );
    }

    for (double lng = (minLng ~/ lnggridSpacing) * lnggridSpacing; lng <= maxLng; lng += lnggridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lng_$lng'),
          points: [
            LatLng(minLat, lng),
            LatLng(maxLat, lng),
          ],
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      );
    }

    setState(() {}); // Trigger a rebuild to update the map with new grid lines
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _zoomIn() {
    _googleMapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _googleMapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void _returnToInitialPosition() {
    _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Test Map Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
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
              SizedBox(height: 90),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to Friend',
                      style: TextStyle(
                        fontFamily: 'BigShouldersText',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
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
              Container(
                height: 380,
                width: 380,
                child: Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: _initialCameraPosition,
                      onMapCreated: (controller) {
                        _googleMapController = controller;
                        _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
                        _googleMapController!.getVisibleRegion().then((bounds) {
                          _createGrid(bounds);
                        });
                      },
                      onCameraIdle: () async {
                        if (_googleMapController != null) {
                          LatLngBounds bounds = await _googleMapController!.getVisibleRegion();
                          _createGrid(bounds);
                        }
                      },
                      markers: {_origin},
                      polylines: _gridLines,
                      minMaxZoomPreference: MinMaxZoomPreference(10, null),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                            onPressed: _zoomIn,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Icon(Icons.zoom_in, color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          ),

                          SizedBox(height: 10),

                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                            onPressed: _zoomOut,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            child: Icon(Icons.zoom_out, color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: FloatingActionButton(
                        onPressed: _returnToInitialPosition,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.center_focus_strong, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
