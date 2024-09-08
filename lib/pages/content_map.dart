import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

class ContentMapPage extends StatefulWidget {
  @override
  ContentMapPageState createState() => ContentMapPageState();
}

class ContentMapPageState extends State<ContentMapPage> {
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
    double latDifference = lat - _capitol.latitude;
    double lngDifference = lng - _capitol.longitude;

    int latIndex = (latDifference / 0.012).floor();
    int lngIndex = (lngDifference / 0.0145).floor();

    latIndex = latIndex.abs();

    String latLabel = '';
    while (latIndex >= 0) {
      latLabel = String.fromCharCode(65 + (latIndex % 26)) + latLabel;
      latIndex = (latIndex ~/ 26) - 1;
    }

    lngIndex = lngIndex.abs();

    String gridLabel = '$latLabel-${lngIndex.toString().padLeft(4, '0')}';

    print('Generated grid label: $gridLabel');

    return gridLabel;
  }

  void _createGrid(LatLngBounds bounds) {
    _gridLines.clear();
    _shadedAreas.clear();

    double lnggridSpacing = 0.0145;
    double latgridSpacing = 0.012;

    double gridMinLat = (_capitol.latitude ~/ latgridSpacing) * latgridSpacing;
    double gridMinLng = (_capitol.longitude ~/ lnggridSpacing) * lnggridSpacing;

    if (_capitol.latitude < 0) gridMinLat -= latgridSpacing;
    if (_capitol.longitude < 0) gridMinLng -= lnggridSpacing;

    double currentLat = _origin.position.latitude;
    double currentLng = _origin.position.longitude;

    double currentGridMinLat = (currentLat ~/ latgridSpacing) * latgridSpacing;
    double currentGridMinLng = (currentLng ~/ lnggridSpacing) * lnggridSpacing;

    if (currentLat < 0) currentGridMinLat -= latgridSpacing;
    if (currentLng < 0) currentGridMinLng -= lnggridSpacing;

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

    _currentGridLabel = _generateGridLabel(currentGridMinLat, currentGridMinLng);
    _currentGridCenter = LatLng(
      currentGridMinLat + latgridSpacing / 2,
      currentGridMinLng + lnggridSpacing / 2,
    );

    surroundingGridLabels = surroundingGrids.map((grid) {
      return _generateGridLabel(grid.latitude, grid.longitude);
    }).toList();

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

    setState(() {}); 
  }

  Future<Offset> _getScreenCoordinates(LatLng latLng) async {
    ScreenCoordinate screenCoordinate = await _googleMapController!.getScreenCoordinate(latLng);
    return Offset(screenCoordinate.x.toDouble(), screenCoordinate.y.toDouble());
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
        statusBarColor: Colors.transparent, 
        systemNavigationBarColor: Colors.transparent, 
        systemNavigationBarIconBrightness: Brightness.dark, 
        statusBarIconBrightness: Brightness.dark, 
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
                  _createGrid(bounds); // Update grid and labels after dragging or zooming
                }
              },
              polylines: _gridLines,
              polygons: _shadedAreas, 
              minMaxZoomPreference: MinMaxZoomPreference(10, null),
            ),

            // Center marker and label for current location grid
            FutureBuilder<Offset>(
              future: _getScreenCoordinates(_origin.position), 
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Offset offset = snapshot.data!;
                  return Stack(
                    children: [
                      Positioned(
                        left: offset.dx - 7.5, 
                        top: offset.dy - 7.5,  
                        child: _getMarker(),   
                      ),
                      Positioned(
                        left: offset.dx - 30,  
                        top: offset.dy + 25,   
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8), // Add rounded corners
                          ),
                          child: Text(
                            _currentGridLabel,
                            style: TextStyle(
                              fontFamily: 'BigShouldersText',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container(); 
              },
            ),

            // Dynamically place the labels for surrounding grids
            for (int i = 0; i < surroundingGrids.length; i++)
              FutureBuilder<Offset>(
                future: _getScreenCoordinates(surroundingGrids[i]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Offset offset = snapshot.data!;
                    return Positioned(
                      left: offset.dx + 32, 
                      top: offset.dy - 80,  
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8), // Add rounded corners
                        ),
                        child: Text(
                          surroundingGridLabels[i],
                          style: TextStyle(
                            fontFamily: 'BigShouldersText',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(); 
                },
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

  Widget _getMarker() {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}
