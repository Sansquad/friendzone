import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

class ContentMapPage extends StatefulWidget {
  @override
  ContentMapPageState createState() => ContentMapPageState();
}

class ContentMapPageState extends State<ContentMapPage> {

  Widget _getMarker() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
      // implement if I want to replace circle with profile image
      // child:
    );
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297), // San Francisco coordinates
    zoom: 13.5,
  );

  GoogleMapController? _googleMapController;

  // Fixed position to generate grid (Madison Capitol | C-197)
  static const LatLng _capitol = LatLng(43.07489216060602, -89.38419409024608); // New position

  Marker _origin = Marker(
    markerId: MarkerId('current_position'),
    position: LatLng(37.773972, -122.431297), // Current location (San Francisco)
    infoWindow: InfoWindow(title: 'Current Location'),
  );

  final Set<Polyline> _gridLines = {};
  final Set<Polygon> _shadedAreas = {};

  LatLng _currentGridCenter = LatLng(0, 0);
  String _currentGridLabel = "";
  List<String> surroundingGridLabels = [];
  List<LatLng> surroundingGrids = [];

  // Function to generate grid label
  String _generateGridLabel(double lat, double lng) {
    // Calculate the row and column indices based on latitude and longitude
    double latDifference = lat - _capitol.latitude;
    double lngDifference = lng - _capitol.longitude;

    int latIndex = (latDifference / 0.012).floor();
    int lngIndex = (lngDifference / 0.0145).floor();

    // Convert latIndex to positive for alphabetic labeling
    latIndex = latIndex.abs();

    // Generate the row label (e.g., A, B, ..., Z, AA, AB, etc.)
    String latLabel = '';
    while (latIndex >= 0) {
      latLabel = String.fromCharCode(65 + (latIndex % 26)) + latLabel;
      latIndex = (latIndex ~/ 26) - 1;
    }

    // Convert lngIndex to positive for labeling
    lngIndex = lngIndex.abs();

    // Return the final grid label with both row and column information
    String gridLabel = '$latLabel-${lngIndex.toString().padLeft(4, '0')}';

    // Print the generated label for debugging
    print('Generated grid label: $gridLabel');

    return gridLabel;
  }

  void _createGrid(LatLngBounds bounds) {
    _gridLines.clear();
    _shadedAreas.clear();

    double lnggridSpacing = 0.0145;
    double latgridSpacing = 0.012;

    // Coordinates for the fixed grid origin
    double gridMinLat = (_capitol.latitude ~/ latgridSpacing) * latgridSpacing;
    double gridMinLng = (_capitol.longitude ~/ lnggridSpacing) * lnggridSpacing;

    if (_capitol.latitude < 0) gridMinLat -= latgridSpacing;
    if (_capitol.longitude < 0) gridMinLng -= lnggridSpacing;

    // Calculate the grid boundaries for the current location
    double currentLat = _origin.position.latitude;
    double currentLng = _origin.position.longitude;

    double currentGridMinLat = (currentLat ~/ latgridSpacing) * latgridSpacing;
    double currentGridMinLng = (currentLng ~/ lnggridSpacing) * lnggridSpacing;

    if (currentLat < 0) currentGridMinLat -= latgridSpacing;
    if (currentLng < 0) currentGridMinLng -= lnggridSpacing;

    // Define the coordinates of the 8 surrounding grids around the current location
    surroundingGrids = [
      LatLng(currentGridMinLat + latgridSpacing, currentGridMinLng), // above
      LatLng(currentGridMinLat - latgridSpacing, currentGridMinLng), // below
      LatLng(currentGridMinLat, currentGridMinLng - lnggridSpacing), // left
      LatLng(currentGridMinLat, currentGridMinLng + lnggridSpacing), // right
      LatLng(currentGridMinLat + latgridSpacing, currentGridMinLng + lnggridSpacing), // top-right
      LatLng(currentGridMinLat + latgridSpacing, currentGridMinLng - lnggridSpacing), // top-left
      LatLng(currentGridMinLat - latgridSpacing, currentGridMinLng + lnggridSpacing), // bottom-right
      LatLng(currentGridMinLat - latgridSpacing, currentGridMinLng - lnggridSpacing), // bottom-left
    ];

    // Lightly shade the grids surrounding the fixed origin point (Capitol)
    for (LatLng grid in surroundingGrids) {
      _shadedAreas.add(
        Polygon(
          polygonId: PolygonId('shade_${grid.latitude}_${grid.longitude}'),
          points: [
            LatLng(grid.latitude, grid.longitude),
            LatLng(grid.latitude + latgridSpacing, grid.longitude),
            LatLng(grid.latitude + latgridSpacing, grid.longitude + lnggridSpacing),
            LatLng(grid.latitude, grid.longitude + lnggridSpacing),
          ],
          fillColor: Colors.black.withOpacity(0.3),
          strokeColor: Colors.transparent,
        ),
      );
    }

    // Set the label and center for the current grid (unshaded)
    _currentGridLabel = _generateGridLabel(currentGridMinLat, currentGridMinLng);
    _currentGridCenter = LatLng(
      currentGridMinLat + latgridSpacing / 2,
      currentGridMinLng + lnggridSpacing / 2,
    );

    // Generate labels for the surrounding grids
    surroundingGridLabels = surroundingGrids.map((grid) {
      return _generateGridLabel(grid.latitude, grid.longitude);
    }).toList();

    // Lightly shade all other grids except the one surrounding the current location
    _shadedAreas.add(
      Polygon(
        polygonId: PolygonId('outer_shade'),
        points: [
          LatLng(bounds.southwest.latitude, bounds.southwest.longitude),
          LatLng(bounds.northeast.latitude, bounds.southwest.longitude),
          LatLng(bounds.northeast.latitude, bounds.northeast.longitude),
          LatLng(bounds.southwest.latitude, bounds.northeast.longitude),
        ],
        holes: [
          [
            LatLng(currentGridMinLat, currentGridMinLng),
            LatLng(currentGridMinLat + latgridSpacing, currentGridMinLng),
            LatLng(currentGridMinLat + latgridSpacing, currentGridMinLng + lnggridSpacing),
            LatLng(currentGridMinLat, currentGridMinLng + lnggridSpacing),
          ],
          ...surroundingGrids.map((grid) => [
            LatLng(grid.latitude, grid.longitude),
            LatLng(grid.latitude + latgridSpacing, grid.longitude),
            LatLng(grid.latitude + latgridSpacing, grid.longitude + lnggridSpacing),
            LatLng(grid.latitude, grid.longitude + lnggridSpacing),
          ])
        ],
        fillColor: Colors.black.withOpacity(0.8),
        strokeColor: Colors.transparent,
      ),
    );

    // Generate grid lines across the map area, ensuring full coverage
    double latStart = (bounds.southwest.latitude ~/ latgridSpacing) * latgridSpacing;
    if (bounds.southwest.latitude < 0) latStart -= latgridSpacing;

    double lngStart = (bounds.southwest.longitude ~/ lnggridSpacing) * lnggridSpacing;
    if (bounds.southwest.longitude < 0) lngStart -= lnggridSpacing;

    for (double lat = latStart; lat <= bounds.northeast.latitude; lat += latgridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lat_$lat'),
          points: [
            LatLng(lat, bounds.southwest.longitude),
            LatLng(lat, bounds.northeast.longitude),
          ],
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      );
    }

    for (double lng = lngStart; lng <= bounds.northeast.longitude; lng += lnggridSpacing) {
      _gridLines.add(
        Polyline(
          polylineId: PolylineId('lng_$lng'),
          points: [
            LatLng(bounds.southwest.latitude, lng),
            LatLng(bounds.northeast.latitude, lng),
          ],
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      );
    }

    setState(() {}); // Trigger a rebuild to update the map with new grid lines, shading, and labels
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        systemNavigationBarColor: Colors.transparent, // transparent navigation bar
        systemNavigationBarIconBrightness: Brightness.dark, // light icons on navigation bar
        statusBarIconBrightness: Brightness.dark, // light icons on status bar
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: <Widget>[
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
              // markers: {_origin},
              polylines: _gridLines,
              polygons: _shadedAreas, // Apply shading to the map
              minMaxZoomPreference: MinMaxZoomPreference(10, null),
            ),

            // dot at current position
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: _getMarker(),
              )

            ),

            // Overlay the text for the current grid
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 30, // Adjust as needed
              top: MediaQuery.of(context).size.height / 2 + 10, // Adjust as needed
              child: Text(
                _currentGridLabel,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  backgroundColor: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            // Overlay the text for the surrounding grids
            for (int i = 0; i < surroundingGrids.length; i++)
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 50 + ((surroundingGrids[i].longitude - _currentGridCenter.longitude) / 0.0145) * 100, // Adjust position based on grid
                top: MediaQuery.of(context).size.height / 2 - 20 + ((surroundingGrids[i].latitude - _currentGridCenter.latitude) / 0.012) * 100, // Adjust position based on grid
                child: Text(
                  surroundingGridLabels[i],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    backgroundColor: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            Positioned(
              top: 50,
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
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
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
            ),
            Positioned(
              top: 30,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/contentlayout');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
