// friends_locations_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends' Locations"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              GeoPoint location = doc['location'];
              return ListTile(
                title: Text(doc['name'] ?? 'Unknown'),
                subtitle: Text(
                    "Location: ${location.latitude}, ${location.longitude}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
