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

              List<TroutData> troutdataList = snapshot.data!;
              
              return InteractiveViewer(
                constrained: false,
                child: DataTable(
                  headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.amber),
                  showBottomBorder: true,





                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('River')),
                    DataColumn(label: Text('Pool')),
                    DataColumn(label: Text('Fish')),
                    DataColumn(label: Text('Size')),
                    DataColumn(label: Text('Icon')),
                    DataColumn(label: Text('Condition')),
                    // DataColumn(label: Text('Kept?')),
                    DataColumn(label: Text('Fly')),
                    DataColumn(label: Text('Notes')),
                  ], 
                  rows: troutdataList.map((dataPoint) => DataRow(
                    cells: [
                      DataCell(Text(dataPoint.dateAndTime.toString())),
                      DataCell(Text(dataPoint.river)),
                      DataCell(Text(dataPoint.river_pool)),
                      DataCell(Text(dataPoint.fish_species)),
                      DataCell(Text(dataPoint.fish_weight.toString())),
                      DataCell(Text(dataPoint.fish_species == 'Rainbow' ? 'rainbfishy' : 'bfishy')),
                      DataCell(Text(dataPoint.fish_condition)),
                      // DataCell(Text(dataPoint.kept_or_released.toString())),
                      DataCell(Text(dataPoint.fly_used)),
                      DataCell(Text(dataPoint.any_notes)),
                    ],

                  ),
                  ).toList(),  //growable: true
                )
              );
            }
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


