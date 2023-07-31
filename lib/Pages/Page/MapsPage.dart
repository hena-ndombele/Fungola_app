import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fungola_app/Pages/Page/ClePage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fungola_app/utils/ColorPage.dart';

class MapsPage extends StatefulWidget {
  // TODO: Add constructor?
  @override
  _MasPageState createState() => _MasPageState();
}

class _MasPageState extends State<MapsPage> {
  late GoogleMapController _mapController;
  List<LatLng> _locations = [];
  List<Marker> _markers = [];
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirebase();
    _setupDbListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }



  void _loadMarkersFromFirebase() async {
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('kits/kit1/locations')
        .limitToLast(10);
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> _json = snapshot.value as Map<dynamic, dynamic>;
      int delay = 0; // Set initial delay to 0

      for (var entry in _json.entries) {
        final String positionId = entry.key;
        final double lat = entry.value['Lat'];
        final double lng = entry.value['Long'];
        final LatLng location = LatLng(lat, lng);

        // Schedule the marker to be added with a delay
        Future.delayed(Duration(minutes: delay), () {
          setState(() {
            _locations.add(location);
            _markers.add(Marker(
              markerId: MarkerId(positionId),
              position: location,
            ));

            // Check if there are at least two locations
            if (_locations.length > 1) {
              // Add a polyline to connect the last two locations
              Polyline polyline = Polyline(
                polylineId: PolylineId('route'),
                points: _locations.sublist(_locations.length - 2),
                color: Utils.COLOR_VIOLET,
                width: 3,
              );
              _polylines.add(polyline);
            }
          });
        });

        delay += 2; // Increment the delay by 5 minutes
      }

      // Center the camera on the last marker position
      _mapController.animateCamera(CameraUpdate.newLatLng(_locations.last));
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
    });
  }
  void _updateMapMarkers() async {
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('kits/kit1/locations')
        .limitToLast(10);
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> _json = snapshot.value as Map<dynamic, dynamic>;
      int delay = 0; // Set initial delay to 0
      for (var entry in _json.entries) {
        final String positionId = entry.key;
        final double lat = entry.value['Lat'];
        final double lng = entry.value['Long'];
        final LatLng location = LatLng(lat, lng);

        // Schedule the marker to be added with a delay
        Future.delayed(Duration(minutes: delay), () {
          setState(() {
            _locations.add(location);
            _markers.add(Marker(
              markerId: MarkerId(positionId),
              position: location,
            ));
          });
        });
        if (_locations.length > 1) {
          Polyline polyline = Polyline(
            polylineId: PolylineId('route'),
            points: _locations,
            color: Utils.COLOR_VIOLET, // Set the color of the polyline
            width: 3, // Set the width of the polyline
          );

          _polylines.clear();
          _polylines.add(polyline);
        }

        delay += 5; // Increment the delay by 5 minutes
      }

      // Center the camera on the last marker position
      _mapController.animateCamera(CameraUpdate.newLatLng(_locations.last));
    }
  }


  List<LatLng> getMarkerPositions() {
    return _locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(-4.3032527, 15.310528),
                  // Set the initial map position
                  zoom: 12.0, // Set the initial zoom level
                ),
                markers: Set.from(_markers),
                polylines: _polylines,
              ),
              Positioned(
                top: 66.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    /*  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );*/
                  },
                  child: Icon(Icons.dashboard),
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
              ),    Positioned(
                top: 206.0,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    List<LatLng> positions = getMarkerPositions();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarkerPositionPage(positions: positions),
                      ),
                    );
                  },
                  child: Icon(Icons.list),
                  backgroundColor: Utils.COLOR_ROUGE,
                ),
              ),]));}}





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
        backgroundColor: Colors.purple,
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
                  builder: (context) => MaPage(position: widget.positions[index]),
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
    List<LatLng> positions = [widget.position]; // Convert the single position into a list

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marker Positions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MarkerPositionPage(
        positions: [
          LatLng(37.7749, -122.4194), // Sample positions, replace with your own
          LatLng(34.0522, -118.2437),
          LatLng(41.8781, -87.6298),
        ],
      ),
    );
  }
}