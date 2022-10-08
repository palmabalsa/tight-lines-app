// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/views/weather_forecast.dart';

class RiverDropDown extends StatefulWidget {
  RiverDropDown({
    Key? key,
    this.graphvalue,
    this.updateGraphValue,
    required this.riverName,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  String? graphvalue;
  Function? updateGraphValue;
  String riverName;
  String lat;
  String lon;

  @override
  State<RiverDropDown> createState() => _RiverDropDownState();
}

class _RiverDropDownState extends State<RiverDropDown> {
  DropdownButtonFormField newDropdown(String anothervalue) {
    return DropdownButtonFormField(
        itemHeight: null,
        decoration: InputDecoration(
          prefixIcon:
              const Icon(MaterialCommunityIcons.waves, color: Colors.black),
          fillColor: Colors.teal.shade50,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(99)),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          enabled: false,
        ),
        dropdownColor: Colors.teal.shade50,
        iconSize: 30,
        isExpanded: true,
        items: const [
          DropdownMenuItem(
            value: '2D',
            child: Text('Last 2 days',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '7D',
            child: Text('Last 7 days',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '1M',
            child: Text('Last Month',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '3M',
            child: Text('Last 3 Months',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 14)),
          ),
        ],
        value: anothervalue,
        onChanged: (value) {
          setState(() {
            anothervalue = value!;
            widget.graphvalue = anothervalue;
            widget.updateGraphValue!(anothervalue);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(children: <Widget>[
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(flex: 1),
            SizedBox(
              width: 230,
              height: 50,
              child: widget.riverName == 'Tongariro' ||
                      widget.riverName == 'Lake O'
                  ? newDropdown(widget.graphvalue!)
                  : Container(
                      padding: const EdgeInsets.only(left: 50, top: 7),
                      child: const Text('Tauranga Taupo',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
            ),
            const Spacer(flex: 1),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeatherForecastView(
                              riverName: widget.riverName,
                              lat: widget.lat,
                              lon: widget.lon,
                            )),
                  );
                },
                icon: Icon(
                  Icons.sunny,
                  color: Colors.amber.shade600,
                ),
                label: SizedBox(
                    height: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.riverName,
                              style: theme.textTheme.bodyText2),
                          Text("Weather", style: theme.textTheme.bodyText2),
                        ]))),
            const Spacer(flex: 1),
          ],
        ),
      ),
      SizedBox(
          height: widget.riverName == 'Tauranga Taupo' ? 25 : null,
          child: widget.riverName == 'Tauranga Taupo'
              ? const Text(
                  'Data from Waikato council: www.waikatoregion.govt.nz')
              : null),
    ]);
  }
}
