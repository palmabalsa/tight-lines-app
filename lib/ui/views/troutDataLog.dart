import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/widgets/data_table.dart';
import 'Create_Catch.dart';

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
    var theme = Theme.of(context);
    final ButtonStyle style=
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    ElevatedButton.styleFrom(primary: Colors.cyan);
    return Scaffold(
      appBar: AppBar(
        title: Text( 'FISHING LOG', style: theme.textTheme.headline5,),
        actions: <Widget>[

          TextButton.icon(
            style: style,
            onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewCatchView()),
                  );
                },
            icon: Icon(Icons.add_circle),
            label: Text('new catch'),
            ),

        ],
      ),
      body: Center(
        child: FutureBuilder<List<TroutData>>(
          future: fishOn,
          builder: (BuildContext context, snapshot) {

            if (snapshot.hasData) {

              List<TroutData> troutdataList = snapshot.data!;

              return TroutDataTable(fishINFO : troutdataList);
             
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

              































// DATATABLE :::::::::::::

 // return InteractiveViewer(
              //   constrained: false,
              //   child: DataTable(
              //     headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
              //     headingRowColor: MaterialStateProperty.resolveWith(
              //       (states) => Colors.amber),
              //     showBottomBorder: true,
              //     sortColumnIndex: isSortingColumn,
              //     sortAscending: isAscendingOrder,

              //     columns: [

              //       // DataColumn(label: Text('Date')),
              //       // DataColumn(label: Text('River')),
              //       DataColumn(label: Text('Pool'),
              //       // onSort: (columnIndex, _) {
              //       //   setState(() {
              //       //     isSortingColumn = columnIndex;
              //       //     if (isAscendingOrder){
              //       //       dataPoint.river_pool.sort((a, b) => b['Pool'].compareTo(a['Pool']));
              //       //     }
              //       //       else{}

              //       //     }
              //       //   });
              //       // }
              //       ),
              //       // DataColumn(label: Text('Fish')),
              //       // DataColumn(label: Text('Size')),
              //       // DataColumn(label: Text('Icon')),
              //       // DataColumn(label: Text('Condition')),
              //       // DataColumn(label: Text('Kept?')),
              //       DataColumn(label: Text('Fly')),
              //       DataColumn(label: Text('Notes')),
              //     ], 
                  
              //     rows: troutdataList.map((dataPoint) => DataRow(
              //       cells: [
              //         // DataCell(Text(dataPoint.dateAndTime.toString())),
              //         // DataCell(Text(dataPoint.river)),
              //         DataCell(Text(dataPoint.river_pool)),
              //         // DataCell(Text(dataPoint.fish_species)),
              //         // DataCell(Text(dataPoint.fish_weight.toString())),
              //         // DataCell(Text(dataPoint.fish_species == 'Rainbow' ? 'rainbfishy' : 'bfishy')),
              //         // DataCell(Text(dataPoint.fish_condition)),
              //         // DataCell(Text(dataPoint.kept_or_released.toString())),
              //         DataCell(Text(dataPoint.fly_used)),
              //         DataCell(Text(dataPoint.any_notes)),
              //       ],

              //     ),
              //     ).toList(),  //growable: true
              //   )
              // );




              // return InteractiveViewer(
              //   constrained: false,
              //   child: DataTable(
              //     headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
              //     headingRowColor: MaterialStateProperty.resolveWith(
              //       (states) => Colors.amber),
              //     showBottomBorder: true,
              //     // sortColumnIndex: isSortingColumn,
              //     // sortAscending: isAscendingOrder,

              //     columns: [

              //       // DataColumn(label: Text('Date')),
              //       // DataColumn(label: Text('River')),
              //       DataColumn(label: Text('Pool'),
              //       // onSort: (columnIndex, _) {
              //       //   setState(() {
              //       //     isSortingColumn = columnIndex;
              //       //     if (isAscendingOrder){
              //       //       dataPoint.river_pool.sort((a, b) => b['Pool'].compareTo(a['Pool']));
              //       //     }
              //       //       else{}

              //       //     }
              //       //   });
              //       // }
              //       ),
              //       // DataColumn(label: Text('Fish')),
              //       // DataColumn(label: Text('Size')),
              //       // DataColumn(label: Text('Icon')),
              //       // DataColumn(label: Text('Condition')),
              //       // DataColumn(label: Text('Kept?')),
              //       DataColumn(label: Text('Fly')),
              //       DataColumn(label: Text('Notes')),
              //     ], 
                  
              //     rows: troutdataList.map((dataPoint) => DataRow(
              //       cells: [
              //         // DataCell(Text(dataPoint.dateAndTime.toString())),
              //         // DataCell(Text(dataPoint.river)),
              //         DataCell(Text(dataPoint.river_pool)),
              //         // DataCell(Text(dataPoint.fish_species)),
              //         // DataCell(Text(dataPoint.fish_weight.toString())),
              //         // DataCell(Text(dataPoint.fish_species == 'Rainbow' ? 'rainbfishy' : 'bfishy')),
              //         // DataCell(Text(dataPoint.fish_condition)),
              //         // DataCell(Text(dataPoint.kept_or_released.toString())),
              //         DataCell(Text(dataPoint.fly_used)),
              //         DataCell(Text(dataPoint.any_notes)),
              //       ],

              //     ),
              //     ).toList(),  //growable: true
              //   )
              // );
