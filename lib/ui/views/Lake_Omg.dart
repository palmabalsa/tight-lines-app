import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/river_drop_down_menu.dart';
import 'package:ttlines2/ui/widgets/river_level_card.dart';

class LakeOmgView extends StatefulWidget {
  const LakeOmgView({
    Key? key,
  }) : super(key: key);

  @override
  _LakeOmgViewState createState() => _LakeOmgViewState();
}

class _LakeOmgViewState extends State<LakeOmgView> {
  String lakeOLat = '-38.99823';
  String lakeOLon = '175.62021';
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
            child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
      Column(children: <Widget>[
        const SizedBox(height: 10),
        RiverDropDown(
          riverName: 'Lake O',
          lat: lakeOLat,
          lon: lakeOLon,
          graphvalue: graphValue,
          updateGraphValue: graphcallbackfunction,
        ),
        RiverLevelCard(
            theme: theme,
            measuringSiteName: 'Lake Otamangakau at Dam',
            measuringSiteUrl: 'Lake%20Otamangakau%20at%20Dam_',
            graphValue: graphValue),
        const SizedBox(
          height: 50,
          child: Text('Data from Genesis: https://www.genesisenergy.co.nz'),
        ),
      ])
    ])));
  }
}
