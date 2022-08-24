import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/troutDataLog.dart';
import 'package:ttlines2/ui/views/Confetti_Screen.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

class NewCatchView extends StatefulWidget {
  const NewCatchView({
    Key? key,
  }) : super(key: key);

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

  // final user = FirebaseAuth.instance.currentUser!;
  // late String? userUID = user.uid;

  TextEditingController riverPoolController = TextEditingController();
  TextEditingController fishWeightController = TextEditingController();
  TextEditingController flyUsedController = TextEditingController();
  TextEditingController anyNotesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  var riverValue = 'Tongariro';
  var fishSpeciesValue = 'Rainbow';
  var fishConditionValue = 'Sashimi';
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        items: newList,
        value: menuOptions[0],
        onChanged: (value) {
          if (fieldName == "River") {
            setState(() {
              riverValue = value!;
            });
          } else if (fieldName == "Condition") {
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: fieldLabel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final ButtonStyle logbuttonstyle = TextButton.styleFrom(
        primary: Colors.tealAccent,
        backgroundColor: Colors.teal,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
    ElevatedButton.styleFrom(primary: Colors.amber);

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushReplacementNamed(context, '/fishinglog');
          //     },
          //     icon: Icon(MaterialCommunityIcons.arrow_left)),
          title: Text(
            'Log Your Catch',
            style: theme.textTheme.headline5,
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(45),
                    width: 325,
                    height: 625,
                    child: Container(
                        width: 90,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DateTimePicker(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      labelText: 'Date',
                                    ),
                                    type: DateTimePickerType.dateTime,
                                    use24HourFormat: false,
                                    locale: Locale('en', 'US'),
                                    initialValue: '',
                                    firstDate: firstdate,
                                    lastDate: lastdate,
                                    // dateLabelText: 'Date',
                                    onChanged: (value) {
                                      setState(() {
                                        dateValue = value;
                                        print(value);
                                        print(dateValue);
                                      });
                                    },
                                    validator: (value) {
                                      print(value);
                                      return null;
                                    }),
                                Spacer(),
                                formDropdown(menuOptions: [
                                  'Tongariro',
                                  'Tauranga Taupo',
                                  'Lake O'
                                ], valueChoice: riverValue, fieldName: 'River'),
                                Spacer(),
                                Formfield(
                                    fieldentry: 'River pool',
                                    fieldController: riverPoolController),
                                Spacer(),
                                formDropdown(
                                    menuOptions: ['Rainbow', 'Brown'],
                                    valueChoice: fishSpeciesValue,
                                    fieldName: 'Species'),
                                Spacer(),
                                numericTextField(
                                    chosenController: fishWeightController,
                                    fieldLabel: 'Weight'),
                                Spacer(),
                                formDropdown(
                                    menuOptions: [
                                      'Sashimi',
                                      'Average',
                                      'Healthy',
                                      'Sick/Spawning'
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
                                    style: logbuttonstyle,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          final fishyBiz = TroutData(
                                            // user: userUID,
                                            user: getUserUID(),
                                            date: DateTime.parse(dateValue),
                                            river: riverValue,
                                            fish_species: fishSpeciesValue,
                                            fish_condition: fishConditionValue,
                                            fish_weight:
                                                fishWeightController.text,
                                            river_pool:
                                                riverPoolController.text,
                                            fly_used: flyUsedController.text,
                                            any_notes: anyNotesController.text,
                                          );
                                          clarity = newCatch(fishyBiz);
                                        });
                                        Navigator.pushReplacementNamed(
                                            // context, '/confetti');
                                            context,
                                            '/fishinglog');
                                        // TroutDataView()),
                                      }
                                    },
                                    child: const Text('Submit')),
                              ],
                            )))))));
  }
}
