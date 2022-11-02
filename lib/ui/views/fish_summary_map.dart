// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/services/trout_data_api.dart';

class FishSummaryMapView extends StatefulWidget {
  FishSummaryMapView({
    Key? key,
    required this.summarydata,
  }) : super(key: key);

  List<TroutData> summarydata;

  @override
  State<FishSummaryMapView> createState() => _FishSummaryMapViewState();
}

class _FishSummaryMapViewState extends State<FishSummaryMapView> {
  late GoogleMapController summaryMapController;
  List<Marker> catchMarkers = [];
  late List<TroutData> newdata = [];

  List<Marker> createMarkers() {
    for (TroutData fish in widget.summarydata) {
      LatLng catchCoords = LatLng(fish.lat!, fish.lon!);
      var fishSize = fish.fishWeight!.split('.').first.toString();
      String fishId = fish.id!.toString();
      String fishSnippet = '${fishSize}kg ${fish.fishSpecies}';
      catchMarkers.add(Marker(
        markerId: MarkerId(fishId),
        position: catchCoords,
        draggable: false,
        infoWindow: InfoWindow(
          title: fish.fishSpecies,
          snippet: fishSnippet,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ));
    }
    return catchMarkers;
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
          const Spacer(),
          SizedBox(
            height: 40,
            width: 50,
            child: Image.asset('assets/images/trout.png', color: Colors.white),
          ),
          const Spacer(flex: 10),
        ]),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set.from(catchMarkers),
        initialCameraPosition: const CameraPosition(
          target: LatLng(-38.993070, 175.818593),
          zoom: 10.0,
        ),
      ),
    );
  }
}
