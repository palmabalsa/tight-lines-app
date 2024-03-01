// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import '../widgets/date_formatting.dart';

class FishSummaryMapView extends StatefulWidget {
  FishSummaryMapView({
    Key? key,
    required this.summarydata,
  }) : super(key: key);

  List<TroutData>? summarydata;

  @override
  State<FishSummaryMapView> createState() => _FishSummaryMapViewState();
}

class _FishSummaryMapViewState extends State<FishSummaryMapView> {
  late GoogleMapController summaryMapController;
  List<Marker> catchMarkers = [];
  late List<TroutData> newdata = [];
  // ignore: prefer_typing_uninitialized_variables

  // Image displayImage(String fishImage) {
  CachedNetworkImage displayImage(String fishImage) {
    // if (fishImage != '') {
    return CachedNetworkImage(
        imageUrl: fishImage,
        fit: BoxFit.cover,
        width: 230,
        height: 300,
        placeholder: (context, url) => const Center(
                child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            )));
    // return Image.network(fishImage,
    // fit: BoxFit.cover, width: 230, height: 300,
    // scale: 1,
    //     loadingBuilder: (BuildContext context, Widget child,
    //         ImageChunkEvent? loadingProgress) {
    //   if (loadingProgress == null) {
    //     return child;
    //   }
    //   return Center(
    //     child: CircularProgressIndicator(
    //       value: loadingProgress.expectedTotalBytes != null
    //           ? loadingProgress.cumulativeBytesLoaded /
    //               loadingProgress.expectedTotalBytes!
    //           : null,
    //     ),
    //   );
    // });
    // } else {
    //   return Image.asset('assets/images/darkbrown_trout.png',
    //       width: 200, height: 100);
    // }
  }

  List<Marker> createMarkers() {
    for (TroutData fish in widget.summarydata!) {
      LatLng catchCoords = LatLng(fish.lat!, fish.lon!);
      String fishDate = dateFormatting(fish.date.toString());
      String fishLocation = fish.river;
      String fishFly = fish.flyUsed!;
      String fishSize = fish.fishWeight != null
          ? '${double.parse(fish.fishWeight!).toStringAsFixed(1)} kg'
          : '';
      String fishImage = fish.fishImage != null ? fish.fishImage!.path : '';
      String fishId = fish.id!.toString();
      String fishKeptStatus = fish.keptOrReleased;
      String fishSpecies = fish.fishSpecies;
      String fishCondition = fish.fishCondition;
      String fishSnippet = '$fishSize $fishSpecies';
      String fishNotes = fish.anyNotes!;

      catchMarkers.add(Marker(
        markerId: MarkerId(fishId),
        position: catchCoords,
        draggable: false,
        infoWindow: InfoWindow(
            title: fishSnippet,
            snippet: fishDate,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: Platform.isIOS ? 300 : 270,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            (fishImage != '')
                                ? displayImage(fishImage)
                                : fishSpecies == 'Rainbow'
                                    ? Image.asset(
                                        'assets/images/rainbowhorizontal_trout.png',
                                        width: 200,
                                        height: 200)
                                    : Image.asset(
                                        'assets/images/darkbrown_trout.png',
                                        width: 200,
                                        height: 200),
                            const Spacer(),

                            Column(
                              children: <Widget>[
                                Spacer(),
                                Text(fishDate,
                                    style: TextStyle(
                                        fontSize: Platform.isIOS ? 20 : 15)),
                                Text(fishLocation,
                                    style: TextStyle(
                                        fontSize: Platform.isIOS ? 20 : 15)),
                                SizedBox(height: Platform.isIOS ? 12 : 10),
                                Container(
                                  height: 1,
                                  width: Platform.isIOS ? 130 : 120,
                                  color: Colors.teal,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: <Widget>[
                                    Text(fishSize,
                                        style: TextStyle(
                                            fontSize:
                                                Platform.isIOS ? 17 : 15)),
                                    SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: fishSpecies == 'Rainbow'
                                            ? Image.asset(
                                                'assets/images/rainbowhorizontal_trout.png')
                                            : Image.asset(
                                                'assets/images/darkbrown_trout.png')),
                                  ],
                                ),
                                Text('$fishCondition condition',
                                    style: TextStyle(
                                        fontSize: Platform.isIOS ? 17 : 12)),
                                Text(fishKeptStatus,
                                    style: TextStyle(
                                        fontSize: Platform.isIOS ? 17 : 12)),
                                SizedBox(height: Platform.isIOS ? 12 : 10),
                                Container(
                                  height: 1,
                                  width: Platform.isIOS ? 130 : 120,
                                  color: Colors.teal,
                                ),
                                SizedBox(height: Platform.isIOS ? 12 : 10),
                                Container(
                                    height: 40,
                                    width: 150,
                                    child: Center(
                                        child: Column(
                                      children: [
                                        if (fishFly.isNotEmpty)
                                          Text('Fly: $fishFly',
                                              style: TextStyle(
                                                  fontSize: Platform.isIOS
                                                      ? 15
                                                      : 10)),
                                        Text(fishNotes,
                                            style: TextStyle(
                                                fontSize:
                                                    Platform.isIOS ? 15 : 10)),
                                      ],
                                    ))),
                                const Spacer(),
                              ],
                            ),
                            // const Spacer(),
                          ],
                        ));
                  });
            }),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
            style: theme.textTheme.headlineSmall,
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
