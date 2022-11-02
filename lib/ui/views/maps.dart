import 'package:label_marker/label_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/ui/views/create_catch.dart';

class MapsView extends StatefulWidget {
  MapsView({
    Key? key,
    required this.riverName,
  }) : super(key: key);

  String riverName;

  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late GoogleMapController mapController;
  List<Marker> hello = [];
  Set<Marker> markers = {};
  LatLng tongaLatLon = const LatLng(-38.993070, 175.818593);
  LatLng ttLatLon = const LatLng(-38.93823, 175.9111);
  LatLng lakeOLatLon = const LatLng(-38.99823, 175.62021);

  LatLng determineCenter() {
    if (widget.riverName == 'Tongariro') {
      return tongaLatLon;
    } else if (widget.riverName == 'TT') {
      return ttLatLon;
    } else if (widget.riverName == 'Lake O') {
      return lakeOLatLon;
    } else {
      return tongaLatLon;
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  addMarkers() {
    for (String poolKey in tongariroPools.keys) {
      // Markers.add(Marker(
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
        // onTap: ,
        // infoWindow: InfoWindow(
        //   title: poolKey,
        consumeTapEvents: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewCatchView(
                      latLon: tongariroPools[poolKey], pool: poolKey)));
        },
        // ),
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ))
          .then((value) {
        setState(() {});
      });
    }
    // List hello = Markers.toList();
    // return hello;
  }

  Set<Marker> addNewMarker(LatLng tappedLocation) {
    setState(() {
      var markerID = tappedLocation.toString();
      // hello = Markers.toList();
      // hello.length > 11 ? hello.removeLast() : null;
      // Markers.length > 11 ? Markers.removeLast() : null;
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
            widget.riverName,
            style: theme.textTheme.headline5,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(children: [
              Row(children: [
                const Spacer(),
                const Icon(Icons.location_pin),
                Text('Click on a Pool, or other location to add your fish',
                    style: theme.textTheme.bodyText2),
                const Spacer(),
              ]),
              const SizedBox(height: 15),
            ]),
          )),
      body: GoogleMap(
        // myLocationButtonEnabled: true,
        // myLocationEnabled: true,

        onMapCreated: _onMapCreated,
        // markers: Set.from(Markers),
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: determineCenter(),
          zoom: 15.0,
        ),
        onTap: addNewMarker,
      ),
    );
  }
}
