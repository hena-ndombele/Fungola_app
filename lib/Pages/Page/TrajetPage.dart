import 'package:flutter/material.dart';
import 'package:fungola_app/Pages/Page/MapsPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MarkerPositionsPage extends StatelessWidget {
  final List<LatLng> positions;

  MarkerPositionsPage({required this.positions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Trajets'),
      ),
      body: ListView.builder(
        itemCount: positions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Marker ${index + 1}'),
            subtitle: Text(
              'Lat: ${positions[index].latitude}, Lng: ${positions[index].longitude}',
            ),
          );
        },
      ),
    );
  }
}