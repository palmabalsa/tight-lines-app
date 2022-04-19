import 'package:flutter/material.dart';

class TongariroView extends StatefulWidget {

  @override
  _TongariroViewState createState() => _TongariroViewState();
}
class _TongariroViewState extends State<TongariroView> {


  String defaultGraphValue = '7D';
  String newVal = '7D';


// DropdownButton<String> newDropdown() {
  
//   String selectedValue = '2D';
//    return DropdownButton<String>(
//           items: [
//             DropdownMenuItem<String>(child: Text('2 day graph'), value: '2D'), 
//             DropdownMenuItem<String>(child: Text('7 day graph'), value: '7D'),
//             DropdownMenuItem<String>(child: Text('1 month graph'), value: '1M'),
//             DropdownMenuItem<String>(child: Text('3 month graph'), value: '3M'),
//           ],
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value!;
//             });
//           }
//    );
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tongariro River'),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                    newVal = value.toString();
                  });
              },
              itemBuilder:(context) => [
                PopupMenuItem(
                  value: '2D',
                  child: Text('2 Day Graph'),
                ),
                PopupMenuItem(
                  value: '7D',
                  child: Text('7 Day Graph'),
                ),
                PopupMenuItem(
                  value: '1M',
                  child: Text('1 Month Graph'),
                ),
                PopupMenuItem(
                  value: '3M',
                  child: Text('3 Month Graph'),
                ),
              ],
            ),

        ],
      ),
      body: Center(
        child: ListView (
          scrollDirection: Axis.vertical,
          children: <Widget>[

            Divider(),

            Text('Tongariro @ Turangi'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Turangi_$newVal.gif'),
            Text('Tongariro @ Poutu Intake'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20downstream%20of%20Poutu%20Intake_$newVal.gif'),
            Text('Tongariro @ Rangipo'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Rangipo_$newVal.gif'),
            Text('Tongariro @ Waipakihi'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Waipakihi_$newVal.gif'),
          





           

          ],

        ),



         ),
      );   
  }
}