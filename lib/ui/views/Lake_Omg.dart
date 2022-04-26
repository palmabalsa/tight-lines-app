import 'package:flutter/material.dart';

class LakeOmgView extends StatefulWidget {
  const LakeOmgView({ Key? key }) : super(key: key);

  @override
  _LakeOmgViewState createState() => _LakeOmgViewState();
}

class _LakeOmgViewState extends State<LakeOmgView> {



String defaultGraphValue = '7D';
  String newValue = '7D';
  String selectedValue = '7D';


DropdownButtonFormField<String> omgDropdown() {
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
      value: newValue,
      onChanged: (value) {
        setState(() {
          newValue = value!;
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
        title: Text('LAKE O',
        style: theme.textTheme.headline5,)
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Lake Level',
            style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
            ),
            Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 4.0),
                  child: SizedBox(
                    width: 170,
                    height: 50,
                    child: omgDropdown(),
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
              child: Text('Lake Otamangakau at Dam'),
              ),
              ),
            ),
              Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Lake%20Otamangakau%20at%20Dam_$newValue.gif')
          ]
        )
      )
    );


    //         Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Lake%20Otamangakau%20at%20Dam_7D.gif')
    //       ],),)
    // );

  }
}