import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/ui/views/Create_Catch.dart';

// API KEY = AIzaSyB3l0WsiRbObmVHm3Naa1uYWBNIzji71wA
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
  List<Marker> Markers = [];
  LatLng TongaLatLon = LatLng(-38.993070, 175.818593);
  LatLng TTLatLon = LatLng(-38.93823, 175.9111);
  LatLng LakeOLatLon = LatLng(-38.99823, 175.62021);

  LatLng determineCenter() {
    if (widget.riverName == 'Tongariro') {
      return TongaLatLon;
    } else if (widget.riverName == 'TT') {
      return TTLatLon;
    } else if (widget.riverName == 'Lake O') {
      return LakeOLatLon;
    } else
      return TongaLatLon;
  }

  Map<String, dynamic> tongariroPools = {
    'Bridge': LatLng(-38.986123, 175.818550),
    'Judges': LatLng(-38.990238, 175.818796),
    'Major Jones': LatLng(-38.999114, 175.812740),
    'Breakfast': LatLng(-38.996442, 175.812594),
    'Duchess': LatLng(-39.026716, 175.814982),
    'Red Hut': LatLng(-39.030650, 175.813866),
    'Cliff': LatLng(-39.040400, 175.822020),
    'Stag': LatLng(-39.013246, 175.815368),
    'Hydro': LatLng(-39.002474, 175.813072),
    'Log': LatLng(-38.973337, 175.807536),
    'Reed': LatLng(-38.972986, 175.803330),
  };

  // List<String> markerIDS = [
  //   'Bridge',
  //   'Judges',
  //   'Major Jones',
  //   'Breakfast',
  //   'Duchess',
  //   'Red Hut',
  //   'Cliff',
  //   'Stag',
  //   'Hydro',
  //   'Log',
  //   'Reed'
  // ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // for (String id in markerIDS) {
    //   mapController.showMarkerInfoWindow(MarkerId(id));
    // }
  }

  addMarkers() {
    for (String poolKey in tongariroPools.keys) {
      Markers.add(Marker(
        // consumeTapEvents: true,
        markerId: MarkerId(poolKey),
        position: tongariroPools[poolKey],
        draggable: false,
        // onTap: ,
        infoWindow: InfoWindow(
          title: poolKey,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewCatchView(
                        latLon: tongariroPools[poolKey], pool: poolKey)));
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }
  }

  List<Marker> addNewMarker(LatLng tappedLocation) {
    setState(() {
      var markerID = tappedLocation.toString();
      Markers.length > 11 ? Markers.removeLast() : null;
      // markers.clear();
      // addMarkers();
      Markers.add(Marker(
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
    return Markers;
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
                Spacer(),
                Icon(Icons.location_pin),
                Text('Click on a Pool, or other location to add your fish',
                    style: theme.textTheme.bodyText2),
                Spacer(),
              ]),
              SizedBox(height: 15),
            ]),
          )),
      body: GoogleMap(
        // myLocationButtonEnabled: true,
        // myLocationEnabled: true,

        onMapCreated: _onMapCreated,
        markers: Set.from(Markers),
        initialCameraPosition: CameraPosition(
          target: determineCenter(),
          zoom: 15.0,
        ),
        onTap: addNewMarker,
      ),
    );
  }
}
