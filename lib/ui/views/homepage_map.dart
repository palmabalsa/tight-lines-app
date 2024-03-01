import 'package:flutter/material.dart';

class HomePageMap extends StatefulWidget {
  const HomePageMap({Key? key}) : super(key: key);

  @override
  State<HomePageMap> createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Fishing Regions of NZ',
              style: theme.textTheme.headlineSmall,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(children: [
                Row(children: [
                  const Spacer(),
                  const Icon(Icons.location_pin),
                  Text('Choose your fishing region',
                      style: theme.textTheme.bodyMedium),
                  const Spacer(),
                ]),
                const SizedBox(height: 15),
              ]),
            )),
        body: Center(child: Image.asset('assets/images/NZMap.gif')));
  }
}
