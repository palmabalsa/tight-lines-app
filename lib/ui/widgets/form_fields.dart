import 'package:flutter/material.dart';

class Formfield extends StatelessWidget {
  Formfield({
    Key? key,
    required this.fieldentry,
    required this.fieldController,
    required this.isSensitiveData,
  }) : super(key: key);

  var fieldentry;
  // final fieldentry;
  final TextEditingController fieldController;
  bool isSensitiveData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSensitiveData == true ? true : false,
      obscuringCharacter: '•',
      autocorrect: isSensitiveData == true ? false : true,
      enableSuggestions: isSensitiveData == true ? false : true,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: fieldentry),
      controller: fieldController,
      validator: (inputValue) {
        if (inputValue == null || inputValue.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
