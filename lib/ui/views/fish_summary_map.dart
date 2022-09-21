// ignore_for_file: must_be_immutable
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:label_marker/label_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/services/trout_data_api.dart';

class fishSummaryMapView extends StatefulWidget {
  fishSummaryMapView({
    Key? key,
    required this.summarydata,
  }) : super(key: key);

  List<TroutData> summarydata;

  @override
  State<fishSummaryMapView> createState() => _fishSummaryMapViewState();
}

class _fishSummaryMapViewState extends State<fishSummaryMapView> {
  late GoogleMapController summaryMapController;
  List<Marker> Markers = [];
  late List<TroutData> newdata = [];

  List<Marker> createMarkers() {
    for (TroutData fish in widget.summarydata) {
      LatLng catchCoords = LatLng(fish.lat!, fish.lon!);
      var fishSize = fish.fish_weight!.split('.').first.toString();
      String fishId = fish.id!.toString();
      String fishSnippet = fishSize + 'kg ' + fish.fish_species.toString();
      Markers.add(Marker(
        markerId: MarkerId(fishId),
        position: catchCoords,
        draggable: false,
        infoWindow: InfoWindow(
          title: fish.fish_species,
          snippet: fishSnippet,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ));
    }
    return Markers;
  }

  void _onMapCreated(GoogleMapController controller) {
    summaryMapController = controller;
  }

  @override
  void initState() {
    super.initState();
    createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(
            'Trout Data',
            style: theme.textTheme.headline5,
          ),
          Spacer(),
          Container(
            height: 40,
            width: 50,
            child: Image.asset('assets/images/trout.png', color: Colors.white),
          ),
          Spacer(flex: 10),
        ]),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set.from(Markers),
        initialCameraPosition: CameraPosition(
          target: LatLng(-38.993070, 175.818593),
          zoom: 10.0,
        ),
      ),
    );
  }
}
