import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fungola_app/Pages/Page/ClePage.dart';
import 'package:fungola_app/Pages/Page/ProfilPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fungola_app/utils/ColorPage.dart';

class MapsPage extends StatefulWidget {
  // TODO: Add constructor?
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController _mapController;
  List<LatLng> _locations = [];
  Set<Marker> _markers = {};
  late BitmapDescriptor _dotIcon;
  late Polyline _polyline;

  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirebase();
    _setupDbListeners();
    _createDotIcon();
    _setPolyline();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _createDotIcon() async {
    final Size canvasSize =
        Size(20, 20); // Adjust the size of the dot icon here

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Draw a purple dot on the canvas with opacity
    final Paint dotPaint = Paint()
      ..color = Colors.purple
          .withOpacity(0.6) // Customize the color and opacity of the dot here
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final double dotRadius = canvasSize.width / 2;
    final Offset center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    canvas.drawCircle(center, dotRadius, dotPaint);

    final ui.Image image = await pictureRecorder.endRecording().toImage(
          canvasSize.width.toInt(),
          canvasSize.height.toInt(),
        );
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    setState(() {
      _dotIcon = BitmapDescriptor.fromBytes(pngBytes);
    });
  }

  void _loadMarkersFromFirebase() async {
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('kits/kit1/locations')
        .limitToLast(200);
    // TODO: Only get the last 10 or 20 location
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> _json = snapshot.value as Map<dynamic, dynamic>;
      _json.forEach((key, data) {
        final String positionId = key;
        final double lat = data['Lat'];
        final double lng = data['Long'];

        setState(() {
          _locations.add(LatLng(lat, lng));
        });
      });

      _updateMapMarkers();
    }
  }

  void _setupDbListeners() async {
    final dbRef = FirebaseDatabase.instance.ref('kits/kit1/current');
    await dbRef.onValue.listen((event) {
      Map<dynamic, dynamic> _json =
          event.snapshot.value as Map<dynamic, dynamic>;
      final String positionId = event.snapshot.key as String;
      final double lat = _json['Lat'];
      final double lng = _json['Long'];
      final LatLng newLocation = LatLng(lat, lng);

      // TODO: Remove the first in the index

      print('New data: ${positionId} - ${lat} : ${lng}');
      _locations.removeAt(0);

      setState(() {
        _locations.add(newLocation);
      });

      _updateMapMarkers();
      _setPolyline();
    });
  }

  void _updateMapMarkers() {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('last'),
        position: _locations.last,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));

      // Update Camera Position
      _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: _locations[_locations.length - 1],
        zoom: 18.0,
      )));
    });
  }

  void _setPolyline() {
    _polyline = Polyline(
      polylineId: PolylineId("polyline_1"),
      points: _locations,
      color: Colors.purple,
      width: 4,
    );
  }

  List<LatLng> getMarkerPositions() {
    return _locations;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(-4.3032527, 15.310528),
            // Set the initial map position
            zoom: 18.0, // Set the initial zoom level
          ),
          markers: _markers,
          polylines: Set<Polyline>.of([_polyline]),
        ),
        Positioned(
          top: 66.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
            child: Icon(Icons.person),
            backgroundColor: Utils.COLOR_VIOLET,
          ),
        ),
        Positioned(
          top: 136.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClePage()),
              );
            },
            child: Icon(Icons.key),
            backgroundColor: Utils.COLOR_NOIR,
          ),
        ),
        Positioned(
          top: 206.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              List<LatLng> positions = getMarkerPositions();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MarkerPositionPage(positions: positions),
                ),
              );
            },
            child: Icon(Icons.list),
            backgroundColor: Utils.COLOR_GREEN,
          ),
        )
      ],
    );
  }
}

class MarkerPositionsPage extends StatefulWidget {
  late final List<LatLng> positions;

  //MarkerPositionPage({required this.positions});

  @override
  _MarkerPositionPageState createState() => _MarkerPositionPageState();
}

class _MarkerPositionPageState extends State<MarkerPositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Trajets'),
        backgroundColor: Utils.COLOR_VIOLET,
      ),
      body: ListView.builder(
        itemCount: widget.positions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Position ${index + 1}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Lat: ${widget.positions[index].latitude}, Lng: ${widget.positions[index].longitude}',
            ),
            onTap: () {
              _navigateToMapPage(index);
            },
          );
        },
      ),
    );
  }

  void _navigateToMapPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          positions: widget.positions,
          selectedIndex: index,
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final List<LatLng> positions;
  final int selectedIndex;

  MapPage({required this.positions, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    LatLng selectedPosition = positions[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ma position'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedPosition,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selectedMarker'),
                  position: selectedPosition,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: positions,
                  color: Utils.COLOR_VIOLET,
                  width: 3,
                ),
              },
            ),
          ),
          ListTile(
            title: Text(
              'Position sélectionnée',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Lat: ${selectedPosition.latitude}, Lng: ${selectedPosition.longitude}',
            ),
          ),
        ],
      ),
    );
  }
}

class MarkerPositionPage extends StatefulWidget {
  final List<LatLng> positions;

  MarkerPositionPage({required this.positions});

  @override
  State<MarkerPositionPage> createState() => _MarkerPositionPageState();
}

class _MarkerPositionsPageState extends State<MarkerPositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Trajets'),
        backgroundColor: Utils.COLOR_VIOLET,
      ),
      body: ListView.builder(
        itemCount: widget.positions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Marker ${index + 1}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Lat: ${widget.positions[index].latitude}, Lng: ${widget.positions[index].longitude}',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MaPage(position: widget.positions[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MaPage extends StatefulWidget {
  final LatLng position;

  MaPage({required this.position});

  @override
  State<MaPage> createState() => _MaPageState();
}

class _MaPageState extends State<MaPage> {
  @override
  Widget build(BuildContext context) {
    List<LatLng> positions = [
      widget.position
    ]; // Convert the single position into a list

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.position,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selectedMarker'),
                  position: widget.position,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: positions,
                  color: Colors.blue,
                  width: 3,
                ),
              },
            ),
          ),
          ListTile(
            title: Text(
              'Position sélectionnée',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Lat: ${widget.position.latitude}, Lng: ${widget.position.longitude}',
            ),
          ),
        ],
      ),
    );
  }
}




