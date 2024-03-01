import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

class RegionalMapView extends StatefulWidget {
  const RegionalMapView({Key? key}) : super(key: key);

  @override
  State<RegionalMapView> createState() => _RegionalMapViewState();
}

class _RegionalMapViewState extends State<RegionalMapView> {
  late GoogleMapController nzMapController;
  final Set<Marker> _markers = {};
  final LatLng _taupoCenter = const LatLng(-38.685692, 176.070206);

  Map<String, dynamic> taupoPools = {
    'Tongariro': const LatLng(-38.993070, 175.818593),
    'Tauranga Taupo': const LatLng(-38.93823, 175.9111),
    'Lake Otamangakau': const LatLng(-38.99823, 175.62021),
    'Waitahanui': const LatLng(-38.786063, 176.077175),
    'Hinemaiaia': const LatLng(-38.854383, 176.019652),
    'Lake Taupo': const LatLng(-38.778300, 175.896097),
    // 'Waikato': const LatLng(-38.99823, 175.62021),
    // 'Waimarino': const LatLng(-38.99823, 175.62021),
    'Waiotaka': const LatLng(-38.953568, 175.839199),
  };

  _makeMarkers() {
    for (String pool in taupoPools.keys) {
      _markers
          .addLabelMarker(LabelMarker(
        label: pool,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.0,
            fontFamily: 'Roboto Bold'),
        markerId: MarkerId(pool),
        position: taupoPools[pool],
        // infoWindow: InfoWindow(
        //   title: pool,)
      ))
          .then((value) {
        setState(() {});
      });
    }
  }

  _determineCenter() {
    return _taupoCenter;
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
          markers: _markers,
          onMapCreated: _onNZMapCreated,
          mapType: MapType.satellite,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _determineCenter(),
            zoom: 10,
            // onTap: ,
          ),
        ));
  }
}
