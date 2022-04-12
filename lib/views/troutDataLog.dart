import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';

class TroutDataView extends StatefulWidget {
  TroutDataView({Key? key}) : super(key: key);

  @override
  State<TroutDataView> createState() => _TroutDataViewState();
}

class _TroutDataViewState extends State<TroutDataView> {
  late Future<List<TroutData>> fishOn;

  @override
  void initState() {
    super.initState();
    fishOn = fetchTroutData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Fishing Log'),
      ),
      body: Center(
        child: FutureBuilder<List<TroutData>>(
          future: fishOn,
          builder: (BuildContext context, snapshot) {

            if (snapshot.hasData) {


              return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                // snapshot.data![index].logo!),
                // ),
                title: Text(snapshot.data![index].river),
                subtitle: Text(snapshot.data![index].fish_species),
              )
              );
            }
                




            //   return InteractiveViewer(
            //     constrained: false,
            //     child: DataTable(
            //       columns: [
            //         DataColumn(label: Text('River')),
            //         DataColumn(label: Text('Fish')),
            //         DataColumn(label: Text('Condition'))
            //       ], 
            //       rows: [
            //         DataRow(cells: [
            //           DataCell(Text('$river')),
            //           DataCell(Text('$fishy')),
            //           DataCell(Text('$condition')),
            //         ]),
            //       ]));
            // }
            else if (snapshot.hasError){
              throw Exception('Error loading the data');
            }
            return CircularProgressIndicator();
          }
        ),
      )
    );
  }
}