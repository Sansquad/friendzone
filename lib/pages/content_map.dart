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

  Marker _origin = Marker(
    markerId: MarkerId('current_position'),
    position: LatLng(37.773972, -122.431297), // Same position as initial camera
    infoWindow: InfoWindow(title: 'Current Location'),
  );

  final Set<Polyline> _gridLines = {};
  final Set<Polygon> _shadedAreas = {};

  void _createGrid(LatLngBounds bounds) {
    _gridLines.clear();
    _shadedAreas.clear();

    double lnggridSpacing = 0.0145;
    double latgridSpacing = 0.012;

    double markerLat = _origin.position.latitude;
    double markerLng = _origin.position.longitude;

    // Calculate the grid boundaries for the marker's position
    double gridMinLat = (markerLat ~/ latgridSpacing) * latgridSpacing;
    double gridMinLng = (markerLng ~/ lnggridSpacing) * lnggridSpacing;

    if (markerLat < 0) gridMinLat -= latgridSpacing;
    if (markerLng < 0) gridMinLng -= lnggridSpacing;

    // Define the coordinates of the 8 surrounding grids
    List<LatLng> surroundingGrids = [
      LatLng(gridMinLat + latgridSpacing, gridMinLng), // above
      LatLng(gridMinLat - latgridSpacing, gridMinLng), // below
      LatLng(gridMinLat, gridMinLng - lnggridSpacing), // left
      LatLng(gridMinLat, gridMinLng + lnggridSpacing), // right
      LatLng(gridMinLat + latgridSpacing, gridMinLng + lnggridSpacing), // top-right
      LatLng(gridMinLat + latgridSpacing, gridMinLng - lnggridSpacing), // top-left
      LatLng(gridMinLat - latgridSpacing, gridMinLng + lnggridSpacing), // bottom-right
      LatLng(gridMinLat - latgridSpacing, gridMinLng - lnggridSpacing), // bottom-left
    ];

    // Lightly shade the 8 surrounding grids
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

    // Shade the rest of the area more heavily, excluding the 9 grids
    List<List<LatLng>> holes = [];

    // Add the current grid as a hole (no shading)
    holes.add([
      LatLng(gridMinLat, gridMinLng),
      LatLng(gridMinLat + latgridSpacing, gridMinLng),
      LatLng(gridMinLat + latgridSpacing, gridMinLng + lnggridSpacing),
      LatLng(gridMinLat, gridMinLng + lnggridSpacing),
    ]);

    // Add the surrounding grids as holes
    for (LatLng grid in surroundingGrids) {
      holes.add([
        LatLng(grid.latitude, grid.longitude),
        LatLng(grid.latitude + latgridSpacing, grid.longitude),
        LatLng(grid.latitude + latgridSpacing, grid.longitude + lnggridSpacing),
        LatLng(grid.latitude, grid.longitude + lnggridSpacing),
      ]);
    }

    // Add the heavily shaded polygon, with holes for the 9 grids
    _shadedAreas.add(
      Polygon(
        polygonId: PolygonId('outer_shade'),
        points: [
          LatLng(bounds.southwest.latitude, bounds.southwest.longitude),
          LatLng(bounds.northeast.latitude, bounds.southwest.longitude),
          LatLng(bounds.northeast.latitude, bounds.northeast.longitude),
          LatLng(bounds.southwest.latitude, bounds.northeast.longitude),
        ],
        holes: holes,
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

    setState(() {}); // Trigger a rebuild to update the map with new grid lines and shading
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
              markers: {_origin},
              polylines: _gridLines,
              polygons: _shadedAreas, // Apply shading to the map
              minMaxZoomPreference: MinMaxZoomPreference(10, null),
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
