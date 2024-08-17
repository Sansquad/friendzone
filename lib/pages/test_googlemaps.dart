import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestMapPage extends StatefulWidget {
  @override
  TestMapPageState createState() => TestMapPageState();
}

class TestMapPageState extends State<TestMapPage> {
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
                        color: Color(0xFF69B7FF),
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
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
