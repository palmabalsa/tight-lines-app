// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/views/WeatherForecast.dart';

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
        // hint: Row(children: [
        //   Icon(MaterialCommunityIcons.waves, color: Colors.teal),
        //   Spacer(),
        //   Text('River Level',
        //       style: TextStyle(
        //           color: Colors.teal.shade700, fontWeight: FontWeight.bold)),
        // ]),
        itemHeight: null,
        decoration: InputDecoration(
          prefixIcon: Icon(MaterialCommunityIcons.waves, color: Colors.black),
          fillColor: Colors.teal.shade50,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(99)),
              borderSide: BorderSide(color: Colors.grey.shade800)),
          enabled: false,
        ),
        dropdownColor: Colors.teal.shade50,
        iconSize: 30,
        isExpanded: true,
        items: [
          DropdownMenuItem(
              child: Text('Last 2 days',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '2D'),
          DropdownMenuItem(
              child: Text('Last 7 days',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '7D'),
          DropdownMenuItem(
              child: Text('Last Month',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '1M'),
          DropdownMenuItem(
              child: Text('Last 3 Months',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '3M'),
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
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          SizedBox(
            width: 230,
            height: 50,
            child: widget.graphvalue != null && widget.updateGraphValue != null
                ? newDropdown(widget.graphvalue!)
                : Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      'Tauranga Taupo',
                      style: theme.textTheme.headline6,
                    )),
          ),
          Spacer(flex: 1),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => weatherForecastView(
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
              label: Container(
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.riverName,
                            style: theme.textTheme.bodyText2),
                        Text("Weather", style: theme.textTheme.bodyText2),
                      ]))),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
