import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/fish_summary_map.dart';
import 'package:ttlines2/ui/views/maps.dart';

// ignore: must_be_immutable
class TroutDataTable extends StatefulWidget {
  TroutDataTable({
    Key? key,
  }) : super(key: key);

  @override
  State<TroutDataTable> createState() => _TroutDataTableState();
}

class _TroutDataTableState extends State<TroutDataTable> {
  String rivername = 'Tongariro';
  Future<List<TroutData>> fishTime = fetchTroutData();
  late TroutDatasource newTroutDataSource;
  bool isLoaded = false;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  // int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  void _sort<T>(
      Comparable<T> getField(TroutData d), int columnIndex, bool ascending) {
    newTroutDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void updateDataTable() {
    setState(() {
      fishTime = fetchTroutData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FutureBuilder<List<TroutData>>(
        future: fishTime,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<TroutData> troutdataincoming = snapshot.data!;
            List<bool> selectionsList = List<bool>.generate(
                troutdataincoming.length, (int index) => false);
            newTroutDataSource = TroutDatasource(
                fishDataSource: troutdataincoming, selections: selectionsList);
            isLoaded = true;

            return Column(children: <Widget>[
              PaginatedDataTable(
                source: newTroutDataSource,
                header: Row(children: [
                  Container(
                    width: 150,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.teal.shade50,
                      decoration: InputDecoration(
                        fillColor: Colors.teal.shade50,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade800)),
                        enabled: false,
                      ),
                      icon: Icon(Icons.add_circle, color: Colors.teal),
                      hint: Text(' Add Catch',
                          style: TextStyle(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.bold)),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<String>(
                            child: Text('Tongariro',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14)),
                            value: 'Tongariro'),
                        DropdownMenuItem<String>(
                            child: Text('TT',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14)),
                            value: 'TT'),
                        DropdownMenuItem<String>(
                            child: Text('Lake O',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14)),
                            value: 'Lake O'),
                      ],
                      onChanged: (selectedValue) {
                        setState(() {
                          rivername = selectedValue!;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MapsView(riverName: rivername)));
                      },
                    ),
                  ),
                ]),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => fishSummaryMapView(
                                    summarydata: troutdataincoming)));
                        // Navigator.pushNamed(context, '/fishSummary');
                      },
                      icon: Icon(
                        MaterialCommunityIcons.map_outline,
                        color: Colors.teal,
                      )),
                  // edit catch button
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       MaterialIcons.edit,
                  //       color: Colors.teal,
                  //     )),
                  IconButton(
                      onPressed: () async {
                        deleteEntry(newTroutDataSource.selectedcatchestodelete);
                        setState(() {
                          // updateDataTable();
                          //   // fishTime = fetchTroutData();
                        });
                      },
                      icon: Icon(
                        MaterialIcons.delete,
                        color: Colors.teal,
                      )),
                ],
                rowsPerPage: 11,
                // rowsPerPage: troutdataincoming.length,
                // rowsPerPage: _rowsPerPage,
                // onRowsPerPageChanged: (int? value) {
                //   setState(() {
                //     _rowsPerPage = value!;
                //   });
                // },
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                onSelectAll: newTroutDataSource.selectAll,
                showCheckboxColumn: false,
                arrowHeadColor: Colors.teal,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('DATE'),
                    //   onSort: (int columnIndex, bool ascending) => _sort<String>(
                    //       (TroutData d) => d.date, columnIndex, ascending)
                  ),
                  DataColumn(
                      label: Text('RIVER'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.river, columnIndex,
                              ascending)),
                  DataColumn(
                      label: Text('POOL'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.river_pool!,
                              columnIndex, ascending)),
                  DataColumn(
                      label: Text('SPECIES'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.fish_species,
                              columnIndex, ascending)),
                  DataColumn(
                      label: Text('CONDITION'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.fish_condition,
                              columnIndex, ascending)),
                  DataColumn(
                      label: Text('WEIGHT'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.fish_weight!,
                              columnIndex, ascending)),
                  DataColumn(
                      label: Text('FLY'),
                      onSort: (int columnIndex, bool ascending) =>
                          _sort<String>((TroutData d) => d.fly_used!,
                              columnIndex, ascending)),
                  DataColumn(
                    label: Text('NOTES'),
                    // onSort: (int columnIndex, bool ascending) => _sort<String>(
                    //     (TroutData d) => d.any_notes, columnIndex, ascending)
                  ),
                ],
              ),
            ]);
          } else {
            return SizedBox(
              height: 500,
              child:
                  Center(heightFactor: 300, child: CircularProgressIndicator()),
            );
          }
        });
  }
}

class TroutDatasource extends DataTableSource {
  List<TroutData> fishDataSource;
  List<bool> selections;

  TroutDatasource({
    required this.fishDataSource,
    required this.selections,
  });

  void _sort<T>(Comparable<T> getField(TroutData d), bool ascending) {
    fishDataSource.sort((TroutData a, TroutData b) {
      if (!ascending) {
        final TroutData c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  String dateFormatting(String date) {
    final thedate = DateTime.parse(date);
    final formatteddate = DateFormat('d/M/yy').format(thedate);
    return formatteddate.toString();
  }

  List<int> selectedcatchestodelete = [];
  int selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= fishDataSource.length) return null;
    final TroutData troutcatchdata = fishDataSource[index];
    return DataRow.byIndex(
        index: index,
        selected: troutcatchdata.thisoneselected,
        onSelectChanged: (bool? value) {
          if (troutcatchdata.thisoneselected != value) {
            selectedCount += value! ? 1 : -1;
            assert(selectedCount >= 0);
            troutcatchdata.thisoneselected = value;
            notifyListeners();
            print(selectedCount);
          }

          if (troutcatchdata.thisoneselected == value &&
              selectedcatchestodelete.contains(troutcatchdata.id) != true) {
            selectedcatchestodelete.add(troutcatchdata.id!);
          } else if (troutcatchdata.thisoneselected == value &&
              selectedcatchestodelete.contains(troutcatchdata.id)) {
            selectedcatchestodelete.remove(troutcatchdata.id!);
          }
          print(selectedcatchestodelete);
        },
        cells: <DataCell>[
          DataCell(Text(dateFormatting('${troutcatchdata.date.toString()}'))),
          DataCell(Text(troutcatchdata.river == 'Tongariro'
              ? 'Tonga'
              : troutcatchdata.river == 'Tauranga Taupo'
                  ? 'TT'
                  : troutcatchdata.river)),
          DataCell(Text('${troutcatchdata.river_pool}')),
          DataCell(troutcatchdata.fish_species == 'Rainbow'
              ? SizedBox(
                  height: 80,
                  width: 60,
                  child:
                      Image.asset('assets/images/rainbowhorizontal_trout.png'),
                )
              : SizedBox(
                  height: 80,
                  width: 60,
                  child: Image.asset('assets/images/darkbrown_trout.png'))),
          DataCell(Text('${troutcatchdata.fish_condition}')),
          DataCell(Text('${troutcatchdata.fish_weight.toString()} kg')),
          DataCell(Text('${troutcatchdata.fly_used}')),
          DataCell(Text('${troutcatchdata.any_notes}')),
        ]);
  }

  @override
  int get rowCount => fishDataSource.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;

  void selectAll(bool? checked) {
    for (TroutData troutcatchdata in fishDataSource)
      troutcatchdata.thisoneselected = checked!;
    selectedCount = checked! ? fishDataSource.length : 0;
    notifyListeners();
  }
}
