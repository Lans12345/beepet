import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackPetTab extends StatefulWidget {
  const TrackPetTab({super.key});

  @override
  State<TrackPetTab> createState() => _TrackPetTabState();
}

class _TrackPetTabState extends State<TrackPetTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    determinePosition();
  }

  var hasLoaded = false;

  bool status = false;

  double lat = 0;
  double long = 0;

  getData() async {
    FirebaseDatabase.instance
        .ref('pettracker')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      setState(() {
        lat = double.parse(data['fcgftrtrtr545']['latitude']);
        long = double.parse(data['fcgftrtrtr545']['longitude']);
      });

      print(double.parse(data['fcgftrtrtr545']['latitude']));

      addMarker(
          double.parse(data['fcgftrtrtr545']['latitude']),
          double.parse(data['fcgftrtrtr545']['longitude']),
          data['fcgftrtrtr545']['petname']);
    });

    setState(() {
      hasLoaded = true;
    });
  }

  Set<Marker> markers = {};

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  addMarker(lat1, long1, String petname) {
    setState(() {
      markers.add(
        Marker(
            draggable: true,
            onDrag: (value) {
              setState(() {
                lat = value.latitude;
                long = value.longitude;
              });
            },
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId('pet location'),
            position: LatLng(lat1, long1),
            infoWindow: InfoWindow(title: petname)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(lat);
    print(long);
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    return Scaffold(
      body: hasLoaded && lat != 0.0
          ? GoogleMap(
              markers: markers,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
