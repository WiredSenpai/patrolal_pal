// home_screen.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:patrol_pal/pages/friends_locationScreen.dart';
import 'location_service.dart';

class HomeScreen extends StatelessWidget {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NotifyNeighborhood')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Position position = await _locationService.getCurrentLocation();
            print(
                'Location Obtained: ${position.latitude}, ${position.longitude}');
            await _locationService.shareLocation(position, '');
            print('Location shared');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );
          },
          child: Text('Share Location and View Map'),
        ),
      ),
    );
  }
}
