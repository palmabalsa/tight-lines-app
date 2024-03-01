import 'dart:io';

import 'package:flutter/material.dart';

class UpdataAppView extends StatefulWidget {
  const UpdataAppView({Key? key}) : super(key: key);

  @override
  State<UpdataAppView> createState() => _UpdataAppViewState();
}

class _UpdataAppViewState extends State<UpdataAppView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
            child: SizedBox(
                height: 250,
                width: 300,
                child: Expanded(
                  child: Column(children: [
                    Image.asset(
                      'assets/images/trout.png',
                      color: Colors.white,
                    ),
                    const SizedBox(height: 50),
                    Text('Get the latest version of the app',
                        style: Platform.isAndroid
                            ? theme.textTheme.titleMedium!
                                .copyWith(color: Colors.white)
                            : theme.textTheme.titleLarge!
                                .copyWith(color: Colors.white)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                          // update app
                          // send user to google app store or apple to update app
                          // if platform == ios?/ android?
                        },
                        child: const Text('Update')),
                  ]),
                ))));
  }
}
