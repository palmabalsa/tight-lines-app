import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/Confetti_Screen.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

// ignore: must_be_immutable
class NewCatchView extends StatefulWidget {
  NewCatchView({
    Key? key,
    required this.latLon,
    this.pool,
  }) : super(key: key);

  LatLng latLon;
  String? pool;

  @override
  State<NewCatchView> createState() => _NewCatchViewState();
}

class _NewCatchViewState extends State<NewCatchView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<TroutData>? clarity;

  var currentUser = FirebaseAuth.instance.currentUser;
  String getUserUID() {
    if (currentUser != null) {
      print(currentUser!.uid);
    }
    return currentUser!.uid;
  }

  TextEditingController riverController = TextEditingController();
  TextEditingController poolController = TextEditingController();
  TextEditingController fishWeightController = TextEditingController();
  TextEditingController flyUsedController = TextEditingController();
  TextEditingController anyNotesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var fishSpeciesValue = 'Rainbow';
  var fishConditionValue = 'Sashimi(Excellent)';
  var dateValue;

  DateTime startdate = DateTime.now();
  late DateTime chosendate;
  DateTime firstdate = DateTime(2022, 6, 6);
  DateTime lastdate = DateTime.now();
  TimeOfDay starttime = TimeOfDay.now();

  DropdownButtonFormField<String> formDropdown(
      {required List<String> menuOptions,
      required var valueChoice,
      required String fieldName}) {
    List<DropdownMenuItem<String>> newList = [];
    for (String menuItem in menuOptions) {
      DropdownMenuItem<String> newItem =
          DropdownMenuItem<String>(child: Text(menuItem), value: menuItem);
      newList.add(newItem);
    }
    return DropdownButtonFormField<String>(
        items: newList,
        value: menuOptions[0],
        onChanged: (value) {
          if (fieldName == "Condition") {
            setState(() {
              fishConditionValue = value!;
            });
          } else if (fieldName == "Species") {
            setState(() {
              fishSpeciesValue = value!;
            });
          }
        });
  }

  TextFormField numericTextField(
      {required TextEditingController chosenController,
      required String fieldLabel}) {
    return TextFormField(
        controller: chosenController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: fieldLabel,
        ));
  }

// based on latLon from user
  // void determinePool() {
  //   if (widget.pool != null) {
  // list of pools and latlongs and map them

  void determineRiverAndPool() {
    if (widget.latLon.longitude <= 175.701685 &&
        widget.latLon.longitude >= 175.525026 &&
        widget.pool == null) {
      riverController.text = 'Lake O';
      poolController.text = '-';
    } else if (widget.latLon.longitude >= 175.701685 &&
        widget.latLon.longitude <= 175.849658 &&
        widget.pool != null) {
      riverController.text = 'Tongariro';
      poolController.text = widget.pool!;
    } else if (widget.latLon.longitude >= 175.701685 &&
        widget.latLon.longitude <= 175.849658 &&
        widget.pool == null) {
      riverController.text = 'Tongariro';
      poolController.text = '-';
    } else if (widget.latLon.longitude >= 175.849658 && widget.pool == null) {
      riverController.text = 'Tauranga Taupo';
      poolController.text = '-';
    }
  }

  @override
  void initState() {
    super.initState();
    determineRiverAndPool();
    // determinePool();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Your Catch',
            style: theme.textTheme.headline5,
          ),
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.fromLTRB(50, 10, 50, 20),
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    width: 100,
                    height: 500,
                    child: Container(
                        width: 90,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DateTimePicker(
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                    ),
                                    type: DateTimePickerType.dateTime,
                                    use24HourFormat: false,
                                    locale: Locale('en', 'US'),
                                    initialValue: lastdate.toString(),
                                    firstDate: firstdate,
                                    lastDate: DateTime.now(),
                                    onChanged: (value) {
                                      setState(() {
                                        dateValue = value;
                                      });
                                    },
                                    validator: (value) {
                                      return null;
                                    }),
                                Spacer(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.teal.shade50,
                                  ),
                                  controller: riverController,
                                  enabled: false,
                                ),
                                Spacer(),
                                // TextFormField(
                                //   decoration: InputDecoration(
                                //     fillColor: Colors.teal.shade50,
                                //   ),
                                //   controller: poolController,
                                //   enabled: true,
                                // ) : null;

                                // Formfield(
                                //     fieldentry: 'River pool',
                                //     fieldController: riverPoolController),
                                Spacer(),
                                formDropdown(
                                    menuOptions: ['Rainbow', 'Brown'],
                                    valueChoice: fishSpeciesValue,
                                    fieldName: 'Species'),
                                Spacer(),
                                numericTextField(
                                    chosenController: fishWeightController,
                                    fieldLabel: 'Weight (kg)'),
                                Spacer(),
                                formDropdown(
                                    menuOptions: [
                                      'Sashimi (Excellent)',
                                      'Good',
                                      'Average',
                                      'Spent'
                                    ],
                                    valueChoice: fishConditionValue,
                                    fieldName: 'Condition'),
                                Spacer(),
                                Formfield(
                                    fieldentry: 'Fly used',
                                    fieldController: flyUsedController),
                                Spacer(),
                                Formfield(
                                    fieldentry: 'Any notes',
                                    fieldController: anyNotesController),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.tealAccent)),
                                  // style: theme.elevatedButtonTheme.style,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        final fishyBiz = TroutData(
                                          user: getUserUID(),
                                          date: DateTime.parse(dateValue),
                                          river: riverController.text,
                                          lat: widget.latLon.latitude,
                                          lon: widget.latLon.longitude,
                                          fish_species: fishSpeciesValue,
                                          fish_condition: fishConditionValue,
                                          fish_weight:
                                              fishWeightController.text,
                                          river_pool: poolController.text,
                                          fly_used: flyUsedController.text,
                                          any_notes: anyNotesController.text,
                                        );
                                        clarity = newCatch(fishyBiz);
                                      });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfettiPlayer(
                                                    fishSpecies:
                                                        fishSpeciesValue,
                                                  )));
                                    }
                                  },
                                  child: const Text('Submit',
                                      style: TextStyle(color: Colors.black)),
                                )
                              ],
                            )))))
          ],
        )));
  }
}
