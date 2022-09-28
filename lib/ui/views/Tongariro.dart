import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/river_drop_down_menu.dart';
import 'package:ttlines2/ui/widgets/river_level_card.dart';

class TongariroView extends StatefulWidget {
  const TongariroView({Key? key}) : super(key: key);

  @override
  State<TongariroView> createState() => _TongariroViewState();
}

class _TongariroViewState extends State<TongariroView> {
  String tongaLat = '-38.95';
  String tongaLon = '175.78333';
  var fontFamily;
  String graphValue = '7D';

  void graphcallbackfunction(String newValue) {
    setState(() {
      graphValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: Center(
            child: ListView(scrollDirection: Axis.vertical, children: [
      Column(
        children: <Widget>[
          const SizedBox(height: 10),
          RiverDropDown(
              riverName: 'Tongariro',
              lat: tongaLat,
              lon: tongaLon,
              graphvalue: graphValue,
              updateGraphValue: graphcallbackfunction),
          RiverLevelCard(
              theme: theme,
              measuringSiteName: 'Tongariro @ Turangi',
              measuringSiteUrl: 'Tongariro%20at%20Turangi_',
              graphValue: graphValue),
          RiverLevelCard(
              theme: theme,
              measuringSiteName: 'Tongariro @ Poutu Intake',
              measuringSiteUrl: 'Tongariro%20downstream%20of%20Poutu%20Intake_',
              graphValue: graphValue),
          RiverLevelCard(
              theme: theme,
              measuringSiteName: 'Tongariro @ Rangipo',
              measuringSiteUrl: 'Tongariro%20at%20Rangipo_',
              graphValue: graphValue),
          RiverLevelCard(
              theme: theme,
              measuringSiteName: 'Tongariro @ Waipakihi',
              measuringSiteUrl: 'Tongariro%20at%20Waipakihi_',
              graphValue: graphValue),
        ],
      )
    ])));
  }
}
