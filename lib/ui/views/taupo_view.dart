import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/ui/views/weather_forecast.dart';

class TaupoView extends StatefulWidget {
  const TaupoView({Key? key}) : super(key: key);

  @override
  State<TaupoView> createState() => _TaupoViewState();
}

class _TaupoViewState extends State<TaupoView> {
  String taupo = 'Lake Taupo';
  LatLng taupoLatLon = const LatLng(-38.792598, 175.894866);

  @override
  Widget build(BuildContext context) {
    return WeatherForecastView(
      waterwayName: 'Lake Taupo',
      lat: taupoLatLon.latitude.toString(),
      lon: taupoLatLon.longitude.toString(),
      isRiver: false,
    );
  }
}
