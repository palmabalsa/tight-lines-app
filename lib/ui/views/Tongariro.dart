import 'package:flutter/material.dart';

class TongariroView extends StatefulWidget {

  @override
  _TongariroViewState createState() => _TongariroViewState();
}
class _TongariroViewState extends State<TongariroView> {


  String defaultGraphValue = '7D';
  String newVal = '7D';
  String selectedValue = '7D';


DropdownButtonFormField<String> newDropdown() {
   return DropdownButtonFormField<String>(

     itemHeight: null,
     decoration: InputDecoration(
       contentPadding: EdgeInsets.all(8.0),
       labelStyle: TextStyle(fontWeight: FontWeight.w900),
       enabledBorder: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.teal.shade50),
         borderRadius: BorderRadius.circular(99),
       ),
       border: OutlineInputBorder(
         borderSide: BorderSide(color: Colors.teal.shade50),
         borderRadius: BorderRadius.circular(99),
       ),
       filled: true,
       fillColor: Colors.teal.shade50,
      ),
      dropdownColor: Colors.teal.shade50,
      iconSize: 30,
      items: [
        DropdownMenuItem<String>(child: Text('2 Day Graph'), value: '2D'), 
        DropdownMenuItem<String>(child: Text('7 Day Graph'), value: '7D'),
        DropdownMenuItem<String>(child: Text('1 Month Graph'), value: '1M'),
        DropdownMenuItem<String>(child: Text('3 Month Graph'), value: '3M'),
      ],
      value: newVal,
      onChanged: (value) {
        setState(() {
          newVal = value!;
        });
      }
   );
}


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TONGARIRO', style: theme.textTheme.headline5,),
        // actions: [
        //   PopupMenuButton(
        //     onSelected: (value) {
        //       setState(() {
        //           newVal = value.toString();
        //         });
        //     },
        //     itemBuilder:(context) => [
        //       PopupMenuItem(
        //         value: '2D',
        //         child: Text('2 Day Graph'),
        //       ),
        //       PopupMenuItem(
        //         value: '7D',
        //         child: Text('7 Day Graph'),
        //       ),
        //       PopupMenuItem(
        //         value: '1M',
        //         child: Text('1 Month Graph'),
        //       ),
        //       PopupMenuItem(
        //         value: '3M',
        //         child: Text('3 Month Graph'),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        child: ListView (
          scrollDirection: Axis.vertical,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('River Level',
                style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 4.0),
                  child: SizedBox(
                    width: 170,
                    height: 50,
                    child: newDropdown(),
                  
                  // child: GraphDropdown(),
                  ),
                ),
              ]
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0 ),
            child: Container(
              height: 22,
              color: Colors.teal.shade50,
              child: Padding(
                padding: EdgeInsets.only(left:10.0),
              child: Text('Tongariro @ Turangi'),
              ),
              ),
            ),
              Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Turangi_$newVal.gif'),

              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0 ),
              child: Container(
              height: 22,
              color: Colors.teal.shade50,
              child: Padding(
                padding: EdgeInsets.only(left:10.0),
              child: Text('Tongariro @ Poutu Intake'),
              ),
              ),
              ),
              Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20downstream%20of%20Poutu%20Intake_$newVal.gif'),

              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0 ),
              child: Container(
              height: 22,
              color: Colors.teal.shade50,
              child: Padding(
                padding: EdgeInsets.only(left:10.0),
              child: Text('Tongariro @ Rangipo'),
              ),
              ),
              ),
              Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Rangipo_$newVal.gif'),

               Padding(
                padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0 ),
             child: Container(
              height: 22,
              color: Colors.teal.shade50,
              child: Padding(
                padding: EdgeInsets.only(left:10.0),
              child: Text('Tongariro @ Waipakihi'),
              ),
             ),
               ),
              Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Waipakihi_$newVal.gif'),
              Divider(),
          ],

        ),
      ),



         ),
      );   
  }
}