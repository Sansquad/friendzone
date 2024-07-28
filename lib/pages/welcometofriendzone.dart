import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async'; // Import for TimeoutException

class WelcomeToFriendZonePage extends StatefulWidget {
  @override
  _WelcomeToFriendZonePageState createState() => _WelcomeToFriendZonePageState();
}

class _WelcomeToFriendZonePageState extends State<WelcomeToFriendZonePage> {
  LatLng _currentPosition = LatLng(0.0, 0.0);
  bool _mapInitialized = false;
  bool _loading = true; // Add loading state
  bool _mockLocation = true; // Add mock location flag

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          setState(() {
            _loading = false;
          });
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          setState(() {
            _loading = false;
          });
          return;
        }
      }

      if (_mockLocation) {
        _locationData = LocationData.fromMap({
          "latitude": 37.7749,
          "longitude": -122.4194,
        });
      } else {
        _locationData = await location.getLocation().timeout(Duration(seconds: 30));
      }

      setState(() {
        _currentPosition = LatLng(_locationData.latitude!, _locationData.longitude!);
        _mapInitialized = true;
        _loading = false; // Stop loading
      });
    } on TimeoutException {
      setState(() {
        _loading = false; // Stop loading in case of timeout
      });
    } catch (e) {
      setState(() {
        _loading = false; // Stop loading in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(), // Show loading indicator
                    SizedBox(height: 20),
                    Text("Loading location..."),
                  ],
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Debug: App is running",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
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
                      _mapInitialized
                          ? Container(
                              height: 300,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: _currentPosition,
                                  zoom: 14.0,
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId('currentLocation'),
                                    position: _currentPosition,
                                  ),
                                },
                              ),
                            )
                          : Text("Unable to fetch location. Make sure location services are enabled."),
                      SizedBox(height: 20),
                      Text(
                        'You are now in Zone C - 197',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Active users: 244',
                        style: TextStyle(
                          fontFamily: 'BigShouldersDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
