// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:label_marker/label_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:ttlines2/ui/views/create_catch.dart';

class MapsView extends StatefulWidget {
  MapsView({
    Key? key,
    required this.waterwayName,
  }) : super(key: key);

  String waterwayName;

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  loc.Location location = loc.Location();
  late GoogleMapController mapController;
  List<Marker> hello = [];
  Set<Marker> markers = {};
  LatLng lakeTaupo = const LatLng(-38.778300, 175.896097);
  LatLng tongaLatLon = const LatLng(-38.993070, 175.818593);
  LatLng ttLatLon = const LatLng(-38.93823, 175.9111);
  LatLng lakeOLatLon = const LatLng(-38.99823, 175.62021);

  LatLng determineCenter() {
    if (widget.waterwayName == 'Tongariro') {
      return tongaLatLon;
    } else if (widget.waterwayName == 'Tauranga Taupo') {
      return ttLatLon;
    } else if (widget.waterwayName == 'Lake O') {
      return lakeOLatLon;
    } else {
      return lakeTaupo;
    }
  }

  Map<String, dynamic> tongariroPools = {
    'Bridge Pool': const LatLng(-38.986123, 175.818550),
    'Judges Pool': const LatLng(-38.990238, 175.818796),
    'Major Jones Pool': const LatLng(-38.999114, 175.812740),
    'Breakfast Pool': const LatLng(-38.996442, 175.812594),
    'Duchess Pool': const LatLng(-39.026716, 175.814982),
    'Red Hut Pool': const LatLng(-39.030650, 175.813866),
    'Cliff Pool': const LatLng(-39.040400, 175.822020),
    'Stag Pool': const LatLng(-39.013246, 175.815368),
    'Hydro Pool': const LatLng(-39.002474, 175.813072),
    'Log Pool': const LatLng(-38.973337, 175.807536),
    'Reed Pool': const LatLng(-38.972986, 175.803330),
  };

  void requestLocationPermission() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    // }
    final userLocation = await location.getLocation();
    setState(() {
      final newCameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude!, userLocation.longitude!),
        zoom: 14.0,
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Platform.isAndroid? requestLocationPermission() : null;
  }

  addMarkers() {
    if (widget.waterwayName == 'Tongariro') {
      for (String poolKey in tongariroPools.keys) {
        markers
            .addLabelMarker(LabelMarker(
          label: poolKey,
          backgroundColor: Colors.teal.shade400,
          textStyle: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              letterSpacing: 1.0,
              fontFamily: 'Roboto Bold'),
          markerId: MarkerId(poolKey),
          position: tongariroPools[poolKey],
          draggable: false,
          consumeTapEvents: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewCatchView(
                        latLon: tongariroPools[poolKey], pool: poolKey)));
          },
        ))
            .then((value) {
          setState(() {});
        });
      }
    } else {
      null;
    }
  }

  Set<Marker> addNewMarker(LatLng tappedLocation) {
    setState(() {
      var markerID = tappedLocation.toString();
      markers.clear();
      addMarkers();
      markers.add(Marker(
        consumeTapEvents: true,
        markerId: MarkerId(markerID),
        position: tappedLocation,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewCatchView(latLon: tappedLocation)));
        },
        // ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
    return markers;
  }

  @override
  void initState() {
    super.initState();
    addMarkers();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.waterwayName,
            style: theme.textTheme.headlineSmall,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(children: [
              Row(children: [
                const Spacer(),
                const Icon(Icons.location_pin, color: Colors.white),
                if (widget.waterwayName == 'Tongariro') const Spacer(),
                Text(
                    widget.waterwayName == 'Tongariro'
                        ? 'Use the Location button, Or choose a pool, Or Drop a Pin \n and then click on it'
                        : 'Use the Location button, Or Drop a Pin & click on it',
                    style: Platform.isAndroid
                        ? theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : theme.textTheme.bodyLarge),
                const Spacer(),
              ]),
              const SizedBox(height: 15),
            ]),
          )),
      body: GoogleMap(
        myLocationButtonEnabled: Platform.isIOS ? true : false,
        myLocationEnabled: true,
        onMapCreated: onMapCreated,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: determineCenter(),
          zoom: widget.waterwayName == 'Lake Taupo' ? 10.5 : 15,
        ),
        onTap: addNewMarker,
      ),
      floatingActionButtonLocation:
          Platform.isAndroid ? FloatingActionButtonLocation.centerFloat : null,
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                requestLocationPermission();
              },
              child: const Icon(Icons.navigation),
            )
          : null,
    );
  }
}
