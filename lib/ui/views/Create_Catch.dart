import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/confetti_screen.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

// final logEntryServiceProvider =
//     FutureProvider.autoDispose<TroutData>((ref) async {
//   return ref.read(troutDataServiceProvider).newCatch();
// });

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
    if (currentUser != null) {}
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
  // ignore: prefer_typing_uninitialized_variables
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
          DropdownMenuItem<String>(value: menuItem, child: Text(menuItem));
      newList.add(newItem);
    }
    return DropdownButtonFormField<String>(
        items: newList,
        hint: Text(fieldName),
        // value: helpertext,
        // value: fieldName,
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

  // TODO :::: add other rivers lat lons, and add a blank option
  // for when the river isnt in the lat/lon vicinity allowed

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
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Trout Data',
            style: theme.textTheme.headline5,
          ),
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(
                        // color: Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    width: 100,
                    height: 500,
                    // replaced container w sizedbox (dart said to)
                    child: SizedBox(
                        width: 90,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // if (Platform.isIOS) {
                                //   return CupertinoPicker

                                // },
                                // else if (Platform.isAndroid){
                                DateTimePicker(
                                    decoration: const InputDecoration(
                                      labelText: 'Date',
                                    ),
                                    type: DateTimePickerType.dateTime,
                                    use24HourFormat: false,
                                    locale: const Locale('en', 'US'),
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

                                const Spacer(),
                                TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade200,
                                  ),
                                  controller: riverController,
                                  enabled: false,
                                ),
                                const Spacer(),
                                formDropdown(
                                    menuOptions: ['Rainbow', 'Brown'],
                                    valueChoice: fishSpeciesValue,
                                    fieldName: 'Species'),
                                const Spacer(),
                                numericTextField(
                                    chosenController: fishWeightController,
                                    fieldLabel: 'Weight? (kg)'),
                                const Spacer(),
                                formDropdown(
                                    menuOptions: [
                                      'Sashimi (Excellent)',
                                      'Good',
                                      'Average',
                                      'Spent'
                                    ],
                                    valueChoice: fishConditionValue,
                                    fieldName: 'Condition'),
                                const Spacer(),
                                Formfield(
                                  fieldentry: 'Fly used?',
                                  fieldController: flyUsedController,
                                  isSensitiveData: false,
                                ),
                                const Spacer(),

                                Formfield(
                                    fieldentry: 'Any notes?',
                                    fieldController: anyNotesController,
                                    isSensitiveData: false),
                                const Spacer(),
                                Center(
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    const EdgeInsets.fromLTRB(
                                                        80.0,
                                                        15.0,
                                                        80.0,
                                                        15.0)),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            final fishyBiz = TroutData(
                                              user: getUserUID(),
                                              date: DateTime.parse(dateValue),
                                              river: riverController.text,
                                              lat: widget.latLon.latitude,
                                              lon: widget.latLon.longitude,
                                              fishSpecies: fishSpeciesValue,
                                              fishCondition: fishConditionValue,
                                              fishWeight:
                                                  fishWeightController.text,
                                              riverPool: poolController.text,
                                              flyUsed: flyUsedController.text,
                                              anyNotes: anyNotesController.text,
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
                                      child: const Text(
                                        'Submit',
                                      )),
                                ),
                              ],
                            )))))
          ],
        )));
  }
}
