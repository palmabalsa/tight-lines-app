import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';

class TroutDataTable extends StatefulWidget {
  const TroutDataTable({
    Key? key,
    required this.fishINFO,
  }) : super(key: key);

   final List<TroutData> fishINFO;

  @override
  State<TroutDataTable> createState() => _TroutDataTableState();
}

class _TroutDataTableState extends State<TroutDataTable> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            source: TroutDatasource(Datadatadata: widget.fishINFO),
            header: Text('Trout Data'),
            rowsPerPage: 10,
            sortColumnIndex: 0,
            sortAscending: true,
            showCheckboxColumn: true,
            arrowHeadColor: Colors.indigo,
            // onSelectAll: , put a delete option here
            columns: [
              DataColumn(label: Text('Pool')),
              DataColumn(label: Text('Fly')),
              DataColumn(label: Text('Notes')),
            ],
          ),
        ]
    );
  }
}

class TroutDatasource extends DataTableSource {
  TroutDatasource({
     required this.Datadatadata, 
  }); 
  final List<TroutData> Datadatadata;


@override
  DataRow getRow(int index) {
    final _myData = Datadatadata[index];
  
    return DataRow.byIndex(
      index: index,
      selected: false,
      // onSelectChanged: ,

      

      cells:<DataCell> [
      DataCell(Text(_myData.river_pool)),
      DataCell(Text(_myData.fly_used)),
      DataCell(Text(_myData.any_notes)),
    ]);
  }

  @override
  int get rowCount => Datadatadata.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;  
}

