// import 'package:flutter/material.dart';

// class GraphDropdown extends StatefulWidget {
  
//   const GraphDropdown({Key? key}) : super(key: key);

//   @override
//   State<GraphDropdown> createState() => _GraphDropdownState();
// }

// class _GraphDropdownState extends State<GraphDropdown> {
  
//   String defaultGraphValue = '7D';
//   String newVal = '7D';
//   String selectedValue = '7D';

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     // DropdownButtonFormField<String> newDropdown() {
//    return DropdownButtonFormField<String>(


//     // style: theme.inputDecorationTheme,
//      itemHeight: null,
//     //  decoration: InputDecoration(
//       //  contentPadding: EdgeInsets.all(8.0),
//       //  labelStyle: TextStyle(fontWeight: FontWeight.w900),
//       //  enabledBorder: OutlineInputBorder(
//       //    borderSide: BorderSide(color: Colors.teal.shade100),
//       //    borderRadius: BorderRadius.circular(99),
//       //  ),
//       //  border: OutlineInputBorder(
//       //    borderSide: BorderSide(color: Colors.teal.shade100),
//       //    borderRadius: BorderRadius.circular(99),
//       //  ),
//       //  filled: true,
//       //  fillColor: Colors.teal.shade100,
//       // ),
//       dropdownColor: Colors.teal.shade100,
//       items: [
//         DropdownMenuItem<String>(child: Text('2 Day Graph'), value: '2D'), 
//         DropdownMenuItem<String>(child: Text('7 Day Graph'), value: '7D'),
//         DropdownMenuItem<String>(child: Text('1 Month Graph'), value: '1M'),
//         DropdownMenuItem<String>(child: Text('3 Month Graph'), value: '3M'),
//       ],
//       value: newVal,
//       onChanged: (value) {
//         setState(() {
//           newVal = value!;
//         });
//       }
//    );
//   }
// }
