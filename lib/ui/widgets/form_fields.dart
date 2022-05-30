import 'package:flutter/material.dart';

class Formfield extends StatelessWidget {
  const Formfield({
    Key? key,
    required this.fieldentry,
    required this.fieldController,
  }) : super(key: key);

  final fieldentry;
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
  return TextFormField(
    decoration: InputDecoration(
    labelText: fieldentry),
    controller: fieldController,
    validator:(inputValue) {
      if (inputValue == null || inputValue.isEmpty) {
        return 'This field is required';
      }
      return null;
      },
    );
}
}