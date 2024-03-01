import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

class NzMapView extends StatefulWidget {
  const NzMapView({Key? key}) : super(key: key);

  @override
  State<NzMapView> createState() => _NzMapViewState();
}

class _NzMapViewState extends State<NzMapView> {
  late GoogleMapController nzMapController;
  final Set<Marker> _taupoMarkers = {};
  final LatLng _taupoCenter = const LatLng(-38.685692, 176.070206);
  final LatLng _nzMapCenter = const LatLng(-38.685692, 176.070206);
  final LatLng wellingtonlatlon = const LatLng(-41.276825, 174.777969);
  final TextStyle labelStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      letterSpacing: 1.0,
      fontFamily: 'Roboto Bold');

  // list of regions:
  Map<String, dynamic> nzRegions = {
    'Northland': const LatLng(-35.7317, 174.3239),
    'Auckland/Waikato': const LatLng(-36.848461, 174.763336),
    'Eastern/Rotorua': const LatLng(-38.662334, 178.017654),
    'Wellington': const LatLng(-41.276825, 174.777969),
  };

  List<List<dynamic>> regions = [
    ['Northland', const LatLng(-34.853432, 173.077564), Colors.red],
    ['Auckland/Waikato', const LatLng(-36.848461, 174.763336), Colors.cyan],
    ['Eastern/Rotorua', const LatLng(-37.761113, 178.466358), Colors.purple],
    ['Hawkes Bay', const LatLng(-39.942549, 176.917383), Colors.green],
    ['Taupo/Turangi', const LatLng(-38.731758, 176.038477), Colors.orange],
    ['Taranaki', const LatLng(-39.265388, 173.791773), Colors.blue],
    ['Wellington', const LatLng(-41.276825, 174.777969), Colors.yellow],
    [
      'Nelson/Marlborough',
      const LatLng(-41.298749, 173.107381),
      Colors.deepPurple
    ],
    ['North Canterbury', const LatLng(-43.004944, 173.085409), Colors.lime],
    ['West Coast', const LatLng(-42.293864, 171.267171), Colors.amber],
    ['Central South Island', const LatLng(-44.398757, 171.212240), Colors.pink],
    ['Otago', const LatLng(-45.687279, 170.075155), Colors.teal],
    ['Southland', const LatLng(-46.248530, 167.916341), Colors.white]
  ];

  _makeMarkers() {
    for (List item in regions) {
      _taupoMarkers
          .addLabelMarker(LabelMarker(
              label: item[0],
              backgroundColor: item[2],
              textStyle: labelStyle,
              markerId: MarkerId(item[0]),
              position: item[1]))
          .then((value) {
        setState(() {});
      });
    }
  }

  void _onNZMapCreated(GoogleMapController controller) {
    nzMapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _makeMarkers();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Fishing Regions of NZ',
              style: theme.textTheme.headlineSmall,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(children: [
                Row(children: [
                  const Spacer(),
                  const Icon(Icons.location_pin),
                  Text('Choose your fishing region',
                      style: theme.textTheme.bodyMedium),
                  const Spacer(),
                ]),
                const SizedBox(height: 15),
              ]),
            )),
        body: GoogleMap(
          markers: _taupoMarkers,
          onMapCreated: _onNZMapCreated,
          mapType: MapType.satellite,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _taupoCenter,
            zoom: 6.5,
            // onTap: ,
          ),
        ));
  }
}
