// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Formfield extends StatelessWidget {
  Formfield({
    Key? key,
    required this.fieldentry,
    required this.fieldController,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var fieldentry;
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: fieldentry,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        hintText: fieldentry,
      ),
      controller: fieldController,
      // validator: (inputValue) {
      //   if (inputValue == null || inputValue.isEmpty) {
      //     return 'This field is required';
      //   }
      //   return null;
      // },
    );
  }
}
