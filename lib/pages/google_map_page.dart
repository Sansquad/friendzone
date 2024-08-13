import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapPagex extends StatefulWidget {
  const GoogleMapPagex({super.key});

  @override
  State<GoogleMapPagex> createState() => _GoogleMapPagexState();
}

class _GoogleMapPagexState extends State<GoogleMapPagex> {
  static const LatLng defaultLocation = LatLng(37.4223, -122.0848);
  GoogleMapController? _controller;
  Position? _currentPosition;
  String _currentZone = "C-197";
  int _activeUsers = 224;
  List<Polyline> _gridLines = [];
  List<Polygon> _shadedGrids = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _generateGridLines();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        if (_controller != null) {
          _controller!.moveCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
          _generateGridLines(); // Regenerate grid lines based on new position
        }
      });
    }
  }

  void _generateGridLines() {
    _gridLines.clear();
    _shadedGrids.clear();
    
    double spacing = 0.012; // Adjust the spacing as needed for approximate square tiles

    double startLat = (_currentPosition?.latitude ?? defaultLocation.latitude) - 0.1;
    double endLat = (_currentPosition?.latitude ?? defaultLocation.latitude) + 0.1;
    double startLng = (_currentPosition?.longitude ?? defaultLocation.longitude) - 0.1;
    double endLng = (_currentPosition?.longitude ?? defaultLocation.longitude) + 0.1;

    for (double lat = startLat; lat <= endLat; lat += spacing) {
      _gridLines.add(Polyline(
        polylineId: PolylineId(lat.toString()),
        points: [LatLng(lat, startLng), LatLng(lat, endLng)],
        color: Colors.blue,
        width: 1,
      ));
    }
    for (double lng = startLng; lng <= endLng; lng += spacing) {
      _gridLines.add(Polyline(
        polylineId: PolylineId(lng.toString()),
        points: [LatLng(startLat, lng), LatLng(endLat, lng)],
        color: Colors.blue,
        width: 1,
      ));
    }

    // Adding shaded polygons for non-active grids
    for (double lat = startLat; lat < endLat; lat += spacing) {
      for (double lng = startLng; lng < endLng; lng += spacing) {
        if (!_isCurrentGrid(lat, lng)) {
          _shadedGrids.add(Polygon(
            polygonId: PolygonId('$lat-$lng'),
            points: [
              LatLng(lat, lng),
              LatLng(lat + spacing, lng),
              LatLng(lat + spacing, lng + spacing),
              LatLng(lat, lng + spacing),
            ],
            fillColor: Colors.grey.withOpacity(0.5),
            strokeWidth: 0,
          ));
        }
      }
    }
  }

  bool _isCurrentGrid(double lat, double lng) {
    if (_currentPosition == null) return false;
    double spacing = 0.014;
    double userLat = _currentPosition!.latitude;
    double userLng = _currentPosition!.longitude;
    return userLat >= lat && userLat < lat + spacing && userLng >= lng && userLng < lng + spacing;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {

            Navigator.pushNamed(context, '/contentlayout'); // Navigate to contentlayout

            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Change the color of the back icon
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
                        color: Color(0xFF69B7FF),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 360,
                height: 293,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                      if (_currentPosition != null) {
                        _controller!.moveCamera(CameraUpdate.newLatLng(
                            LatLng(_currentPosition!.latitude, _currentPosition!.longitude)));
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition != null
                          ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                          : defaultLocation,
                      zoom: 13,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    polylines: Set<Polyline>.of(_gridLines),
                    polygons: Set<Polygon>.of(_shadedGrids),
                    markers: {
                      Marker(
                        markerId: MarkerId('SourceLocation'),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _currentPosition != null
                            ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                            : defaultLocation,
                      ),
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'You are now in Zone $_currentZone',
                style: TextStyle(
                  fontFamily: 'BigShouldersDisplay',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Active users: $_activeUsers',
                style: TextStyle(
                  fontFamily: 'BigShouldersDisplay',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
