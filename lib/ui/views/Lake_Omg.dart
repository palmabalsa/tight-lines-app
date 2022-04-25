import 'package:flutter/material.dart';

class LakeOmgView extends StatefulWidget {
  const LakeOmgView({ Key? key }) : super(key: key);

  @override
  _LakeOmgViewState createState() => _LakeOmgViewState();
}

class _LakeOmgViewState extends State<LakeOmgView> {
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
          children: [
            Text('Lake Omg Water Level'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Lake%20Otamangakau%20at%20Dam_7D.gif')
          ],),)
    );

  }
}