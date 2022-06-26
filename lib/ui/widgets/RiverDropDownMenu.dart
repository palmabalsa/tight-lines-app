// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class RiverDropDown extends StatefulWidget {
  RiverDropDown({
    Key? key,
    required this.rivertitle,
    required this.graphvalue,
    required this.updateGraphValue,
  }) : super(key: key);

  String rivertitle;
  String graphvalue;
  Function updateGraphValue;

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
          DropdownMenuItem<String>(child: Text('2 Days'), value: '2D'),
          DropdownMenuItem<String>(child: Text('7 Days'), value: '7D'),
          DropdownMenuItem<String>(child: Text('1 Month'), value: '1M'),
          DropdownMenuItem<String>(child: Text('3 Months'), value: '3M'),
        ],
        value: anothervalue,
        onChanged: (value) {
          setState(() {
            anothervalue = value!;
            widget.graphvalue = anothervalue;
            widget.updateGraphValue(anothervalue);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          SizedBox(
            width: 120,
            height: 40,
            child: newDropdown(widget.graphvalue),
          ),
          Spacer(flex: 1),
          Text(
            widget.rivertitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer(flex: 20),
        ],
      ),
    );
  }
}
