import 'package:flutter/material.dart';


class CustomDropdown extends StatefulWidget {
  CustomDropdown({
    Key? key,
    // required this.chosenValue,
    required this.choicesList,
  }) : super(key: key);

  // late final String chosenValue;
  final List<String> choicesList;


  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}
class _CustomDropdownState extends State<CustomDropdown> {
  late String dropdownvalue;
  late List<String> allvalues;

List<DropdownMenuItem<String>> createItems(List<String> choices) {
  List<DropdownMenuItem<String>> newItems = [];
  for (String item in choices) {
        var newItem = DropdownMenuItem(
          child: Text(item),
          value: item,
          );
        newItems.add(newItem);
      }
      return newItems;
}


  @override
  Widget build(BuildContext context) {
  return DropdownButtonFormField<String>(
        items: createItems(widget.choicesList),
        value: dropdownvalue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            allvalues.add(newValue);
            print (dropdownvalue);
            // widget.chosenValue = dropdownvalue;
          });
        });
    }
}