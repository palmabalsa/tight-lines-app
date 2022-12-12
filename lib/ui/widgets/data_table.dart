import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/fish_summary_map.dart';
import 'package:ttlines2/ui/views/maps.dart';

final datatableDataProvider =
    FutureProvider.autoDispose<List<TroutData>>((ref) async {
  return ref.read(troutDataServiceProvider).fetchTroutData();
});

// ignore: must_be_immutable
// class TroutDataTable extends StatefulWidget {
class TroutDataTable extends ConsumerStatefulWidget {
  const TroutDataTable({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TroutDataTable> createState() => _TroutDataTableState();
  // State<TroutDataTable> createState() => _TroutDataTableState();
}

class _TroutDataTableState extends ConsumerState<TroutDataTable> {
  // class _TroutDataTableState extends State<TroutDataTable>{

  String rivername = 'Tongariro';
  late TroutDatasource newTroutDataSource;
  bool isLoaded = false;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void _sort<T>(
      Comparable<T> getField(TroutData d), int columnIndex, bool ascending) {
    newTroutDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final networkrequest = ref.watch(datatableDataProvider);
    return networkrequest.when(
      error: (err, stack) => Text('Error: $err'),
      loading: () {
        return const SizedBox(
          height: 500,
          child: Center(heightFactor: 300, child: CircularProgressIndicator()),
        );
      },
      data: (troutdataincoming) {
        List<bool> selectionsList =
            List<bool>.generate(troutdataincoming.length, (int index) => false);
        newTroutDataSource = TroutDatasource(
            fishDataSource: troutdataincoming, selections: selectionsList);
        isLoaded = true;
        return PaginatedDataTable(
          source: newTroutDataSource,
          header: Row(children: [
            SizedBox(
              width: 150,
              height: 40,
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.teal.shade50,
                decoration: InputDecoration(
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(99)),
                      borderSide: BorderSide(color: Colors.grey.shade800)),
                  enabled: false,
                ),
                icon: const Icon(Icons.add_circle, color: Colors.teal),
                hint: Text(' Add Trout',
                    style: TextStyle(
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold)),
                isExpanded: true,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Tongariro',
                    child: Text('Tongariro',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'TT',
                    child: Text('TT',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Lake O',
                    child: Text('Lake O',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 14)),
                  ),
                  // DropdownMenuItem<String>(
                  //   value: 'Tongariro',
                  //   child: Text('Other',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w900,
                  //           fontSize: 14)),
                  // )
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
                          builder: (context) => FishSummaryMapView(
                              summarydata: troutdataincoming)));
                },
                icon: const Icon(
                  MaterialCommunityIcons.map_outline,
                  color: Colors.teal,
                )),
            // edit catch button::::::
            // IconButton(
            //     onPressed: () {

            //     },
            //     icon: const Icon(
            //       MaterialIcons.edit,
            //       color: Colors.teal,
            //     )),
            // delete fish button::::::
            IconButton(
                onPressed: () async {
                  ref
                      .read(troutDataServiceProvider)
                      .deleteEntry(newTroutDataSource.selectedcatchestodelete);
                  // ref.watch(datatableDataProvider);
                },
                icon: const Icon(
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
            const DataColumn(
              label: Text('DATE'),
              //   onSort: (int columnIndex, bool ascending) => _sort<String>(
              //       (TroutData d) => d.date, columnIndex, ascending)
            ),
            DataColumn(
                label: const Text('RIVER'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.river, columnIndex, ascending)),
            DataColumn(
                label: const Text('POOL'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.riverPool!, columnIndex, ascending)),
            DataColumn(
                label: const Text('SPECIES'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.fishSpecies, columnIndex, ascending)),
            DataColumn(
                label: const Text('CONDITION'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.fishCondition, columnIndex, ascending)),
            DataColumn(
                label: const Text('WEIGHT'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.fishWeight!, columnIndex, ascending)),
            DataColumn(
                label: const Text('FLY'),
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TroutData d) => d.flyUsed!, columnIndex, ascending)),
            const DataColumn(
              label: Text('NOTES'),
              // onSort: (int columnIndex, bool ascending) => _sort<String>(
              //     (TroutData d) => d.any_notes, columnIndex, ascending)
            ),
          ],
        );
      },
    );

    // return FutureBuilder<List<TroutData>>(
    //     future: fishTime,
    //     builder: (BuildContext context, snapshot) {
    //       if (snapshot.hasData) {
    //         List<TroutData> troutdataincoming = snapshot.data!;
    //         List<bool> selectionsList = List<bool>.generate(
    //             troutdataincoming.length, (int index) => false);
    //         newTroutDataSource = TroutDatasource(
    //             fishDataSource: troutdataincoming, selections: selectionsList);
    //         isLoaded = true;

    // return Column(children: <Widget>[
    //   PaginatedDataTable(
    //     source: newTroutDataSource,
    //     header: Row(children: [
    //       SizedBox(
    //         width: 150,
    //         height: 40,
    //         child: DropdownButtonFormField<String>(
    //           dropdownColor: Colors.teal.shade50,
    //           decoration: InputDecoration(
    //             fillColor: Colors.teal.shade50,
    //             border: OutlineInputBorder(
    //                 borderRadius:
    //                     const BorderRadius.all(Radius.circular(99)),
    //                 borderSide:
    //                     BorderSide(color: Colors.grey.shade800)),
    //             enabled: false,
    //           ),
    //           icon: const Icon(Icons.add_circle, color: Colors.teal),
    //           hint: Text(' Add Trout',
    //               style: TextStyle(
    //                   color: Colors.teal.shade700,
    //                   fontWeight: FontWeight.bold)),
    //           isExpanded: true,
    //           items: const [
    //             DropdownMenuItem<String>(
    //               value: 'Tongariro',
    //               child: Text('Tongariro',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w900,
    //                       fontSize: 14)),
    //             ),
    //             DropdownMenuItem<String>(
    //               value: 'TT',
    //               child: Text('TT',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w900,
    //                       fontSize: 14)),
    //             ),
    //             DropdownMenuItem<String>(
    //               value: 'Lake O',
    //               child: Text('Lake O',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontWeight: FontWeight.w900,
    //                       fontSize: 14)),
    //             ),
    //             // DropdownMenuItem<String>(
    //             //   value: 'Tongariro',
    //             //   child: Text('Other',
    //             //       style: TextStyle(
    //             //           color: Colors.black,
    //             //           fontWeight: FontWeight.w900,
    //             //           fontSize: 14)),
    //             // )
    //           ],
    //           onChanged: (selectedValue) {
    //             setState(() {
    //               rivername = selectedValue!;
    //             });
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) =>
    //                         MapsView(riverName: rivername)));
    //           },
    //         ),
    //       ),
    //     ]),
    //     actions: <Widget>[
    //       IconButton(
    //           onPressed: () {
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => FishSummaryMapView(
    //                         summarydata: troutdataincoming)));
    //             // Navigator.pushNamed(context, '/fishSummary');
    //           },
    //           icon: const Icon(
    //             MaterialCommunityIcons.map_outline,
    //             color: Colors.teal,
    //           )),
    //       // edit catch button
    //       // IconButton(
    //       //     onPressed: () {},
    //       //     icon: Icon(
    //       //       MaterialIcons.edit,
    //       //       color: Colors.teal,
    //       //     )),
    //       IconButton(
    //           onPressed: () async {
    //             deleteEntry(newTroutDataSource.selectedcatchestodelete);
    //             setState(() {
    //               // updateDataTable();
    //               //   // fishTime = fetchTroutData();
    //             });
    //           },
    //           icon: const Icon(
    //             MaterialIcons.delete,
    //             color: Colors.teal,
    //           )),
    //     ],
    //     rowsPerPage: 11,
    //     // rowsPerPage: troutdataincoming.length,
    //     // rowsPerPage: _rowsPerPage,
    //     // onRowsPerPageChanged: (int? value) {
    //     //   setState(() {
    //     //     _rowsPerPage = value!;
    //     //   });
    //     // },
    //     sortColumnIndex: _sortColumnIndex,
    //     sortAscending: _sortAscending,
    //     onSelectAll: newTroutDataSource.selectAll,
    //     showCheckboxColumn: false,
    //     arrowHeadColor: Colors.teal,
    //     columns: <DataColumn>[
    //       const DataColumn(
    //         label: Text('DATE'),
    //         //   onSort: (int columnIndex, bool ascending) => _sort<String>(
    //         //       (TroutData d) => d.date, columnIndex, ascending)
    //       ),
    //       DataColumn(
    //           label: const Text('RIVER'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.river, columnIndex,
    //                   ascending)),
    //       DataColumn(
    //           label: const Text('POOL'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.riverPool!,
    //                   columnIndex, ascending)),
    //       DataColumn(
    //           label: const Text('SPECIES'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.fishSpecies,
    //                   columnIndex, ascending)),
    //       DataColumn(
    //           label: const Text('CONDITION'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.fishCondition,
    //                   columnIndex, ascending)),
    //       DataColumn(
    //           label: const Text('WEIGHT'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.fishWeight!,
    //                   columnIndex, ascending)),
    //       DataColumn(
    //           label: const Text('FLY'),
    //           onSort: (int columnIndex, bool ascending) =>
    //               _sort<String>((TroutData d) => d.flyUsed!,
    //                   columnIndex, ascending)),
    //       const DataColumn(
    //         label: Text('NOTES'),
    //         // onSort: (int columnIndex, bool ascending) => _sort<String>(
    //         //     (TroutData d) => d.any_notes, columnIndex, ascending)
    //       ),
    //     ],
    //   ),
    // ]);
    // } else {
    //   return const SizedBox(
    //     height: 500,
    //     child:
    //         Center(heightFactor: 300, child: CircularProgressIndicator()),
    //   );
  }
  // });
  // }
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
            // print(selectedCount);
          }

          if (troutcatchdata.thisoneselected == value &&
              selectedcatchestodelete.contains(troutcatchdata.id) != true) {
            selectedcatchestodelete.add(troutcatchdata.id!);
          } else if (troutcatchdata.thisoneselected == value &&
              selectedcatchestodelete.contains(troutcatchdata.id)) {
            selectedcatchestodelete.remove(troutcatchdata.id!);
          }
          // print(selectedcatchestodelete);
        },
        cells: <DataCell>[
          DataCell(Text(dateFormatting(troutcatchdata.date.toString()))),
          DataCell(Text(troutcatchdata.river == 'Tongariro'
              ? 'Tonga'
              : troutcatchdata.river == 'Tauranga Taupo'
                  ? 'TT'
                  : troutcatchdata.river)),
          DataCell(Text('${troutcatchdata.riverPool}')),
          DataCell(troutcatchdata.fishSpecies == 'Rainbow'
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
          DataCell(Text(troutcatchdata.fishCondition)),
          DataCell(Text('${troutcatchdata.fishWeight.toString()} kg')),
          DataCell(Text('${troutcatchdata.flyUsed}')),
          DataCell(Text('${troutcatchdata.anyNotes}')),
        ]);
  }

  @override
  int get rowCount => fishDataSource.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;

  void selectAll(bool? checked) {
    for (TroutData troutcatchdata in fishDataSource) {
      troutcatchdata.thisoneselected = checked!;
      selectedCount = checked ? fishDataSource.length : 0;
      notifyListeners();
    }
  }
}
