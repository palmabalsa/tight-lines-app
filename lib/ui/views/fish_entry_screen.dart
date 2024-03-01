import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IndividualFishEntry extends StatefulWidget {
  IndividualFishEntry({
    Key? key,
    this.fishImage,
    this.fishSnippet,
  }) : super(key: key);

  File? fishImage;
  String? fishSnippet;

  @override
  State<IndividualFishEntry> createState() => _IndividualFishEntryState();
}

class _IndividualFishEntryState extends State<IndividualFishEntry> {
  @override
  Widget build(BuildContext context) {
    // hello = newfishimage().toString();
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.orange.shade900),
        body: Center(
            child: SizedBox(
          height: 700,
          width: 700,
          child: Column(children: [
            const Text("fish of the day:"),
            Text(widget.fishSnippet!),
            SizedBox(
              height: 500,
              width: 500,
              child: widget.fishImage != null
                  ? Image.network(widget.fishImage!.path, scale: 1,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    })
                  : Container(
                      color: Colors.pink,
                    ),
            )
          ]),
        )));
  }
}
