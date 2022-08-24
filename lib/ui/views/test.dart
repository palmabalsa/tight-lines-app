import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';

class testingtesting extends StatefulWidget {
  const testingtesting({Key? key}) : super(key: key);

  @override
  State<testingtesting> createState() => _testingtestingState();
}

class _testingtestingState extends State<testingtesting> {
  Future<List<TroutData>> fishTest = fetchTroutData();

  @override
  void initState() {
    super.initState();
    fishTest = fetchTroutData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 2000,
        child: FutureBuilder<List<TroutData>>(
            future: fishTest,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<TroutData> newdata = snapshot.data!;
                final someDataPoint = snapshot.data!.length;
                final anotherData = snapshot.data![0];
                print(someDataPoint);
                print(newdata);
                print(anotherData);
                return Container(
                  width: 200,
                  child: Text(newdata.toString()),
                );
              } else {
                return CircularProgressIndicator(color: Colors.red);
              }
            }));
  }
}
