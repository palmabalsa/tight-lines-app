// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
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
  DropdownButtonFormField<String> newDropdown(String anothervalue) {
    return DropdownButtonFormField<String>(
        itemHeight: null,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          enabled: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade100),
            borderRadius: BorderRadius.circular(99),
          ),
          filled: true,
          fillColor: Colors.teal.shade100,
        ),
        dropdownColor: Colors.teal.shade100,
        iconSize: 15,
        items: [
          DropdownMenuItem<String>(
              child: Text('Last 2 days',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '2D'),
          DropdownMenuItem<String>(
              child: Text('Last 7 days',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '7D'),
          DropdownMenuItem<String>(
              child: Text('Last Month',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              value: '1M'),
          DropdownMenuItem<String>(
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
            width: 127,
            height: 40,
            child: widget.graphvalue != null && widget.updateGraphValue != null
                ? newDropdown(widget.graphvalue!)
                : Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      'TT',
                      style: theme.textTheme.headline6,
                    )),
          ),
          Spacer(flex: 2),
          Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Image.asset('assets/images/trout.png'),
                ],
              )),
          Spacer(flex: 2),
          TextButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99))),
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
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.bold)),
                        Text("Weather",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.bold))
                      ]))),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
