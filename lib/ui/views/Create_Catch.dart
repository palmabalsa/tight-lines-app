import 'dart:io';
import 'dart:ui';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

enum ImageSourceType { gallery, camera }

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
  var fishConditionValue = 'Excellent';
  var keptOrReleasedValue = 'Kept';
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
      DropdownMenuItem<String> newItem = DropdownMenuItem<String>(
          value: menuItem,
          child: Text(menuItem,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)));
      newList.add(newItem);
    }
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          // labelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelText: ' $fieldName ?',
        ),
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
          } else if (fieldName == "Kept or Released") {
            setState(() {
              keptOrReleasedValue = value!;
            });
          }
        });
  }

  TextFormField numericTextField(
      {required TextEditingController chosenController,
      required String fieldLabel}) {
    return TextFormField(
      controller: chosenController,
      textInputAction: Platform.isAndroid ? TextInputAction.done : null,
      keyboardType: Platform.isAndroid
          ? TextInputType.number
          : Platform.isIOS
              ? const TextInputType.numberWithOptions(
                  signed: true, decimal: false)
              : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null; // Allows null values
        }

        final n = num.tryParse(value);
        if (n == null) {
          return 'Please enter a valid number';
        }
        if (n is int || n.toStringAsFixed(1) == value) {
          fishWeightController.text = n.toStringAsFixed(1);
          // return 'Please enter a value with one decimal place';
        }
        return null;
      },
      onSaved: (value) {
        if (value == null || value.isEmpty) {
          fishWeightController.text = ''; // Set empty string for null values
        } else {
          final n = num.tryParse(value);
          if (n != null) {
            fishWeightController.text =
                n.toStringAsFixed(1); // Save with one decimal place
          }
        }
      },
      decoration: InputDecoration(
        labelStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        labelText: fieldLabel,
      ),
    );
  }

  // add other rivers lat lons, and add a blank option
  // for when the river isnt in the lat/lon vicinity allowed

  void determineRiverAndPool() {
    if (widget.latLon.longitude <= 175.701685 &&
        widget.latLon.longitude >= 175.525026 &&
        widget.pool == null) {
      riverController.text = 'Lake O';
      poolController.text = '';
    } else if (widget.latLon.longitude >= 175.701685 &&
        widget.latLon.longitude <= 175.849658 &&
        widget.pool != null) {
      riverController.text = 'Tongariro';
      poolController.text = widget.pool!;
    } else if (widget.latLon.longitude >= 175.701685 &&
        widget.latLon.longitude <= 175.849658 &&
        widget.pool == null) {
      riverController.text = 'Tongariro';
      poolController.text == '';
    } else if (widget.latLon.longitude >= 175.849658 && widget.pool == null) {
      riverController.text = 'Tauranga Taupo';
      poolController.text = '';
    }
  }

  ButtonStyle imageButtonStyles = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Colors.teal),
      iconColor: MaterialStateProperty.resolveWith((states) => Colors.white));

  @override
  void initState() {
    super.initState();
    determineRiverAndPool();
  }

  File? imagepath;
  String? imageAsString;
  bool imageIsSubmitted = false;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().getImage(
        source: imageSource,
      );
      setState(() {
        if (image != null) {
          imagepath = File(image.path);
          imageIsSubmitted = true;
        } else {
          print('No image selected');
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Trout Data',
            style: theme.textTheme.headlineSmall,
          ),
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            const SizedBox(height: 30),
            SingleChildScrollView(
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: const EdgeInsets.fromLTRB(30, 5, 30, 20),
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 30),
                    width: 100,
                    height: Platform.isIOS ? 700 : 650,
                    // replaced container w sizedbox (dart said to)
                    child: SizedBox(
                        width: 90,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // if (Platform.isIOS) {
                                //   return CupertinoButton(
                                //   onPressed: () => _showDialog(
                                //   CupertinoDatePicker(
                                //     initialDateTime: startdate,
                                //     mode: CupertinoDatePickerMode.dateAndTime,
                                //     onDateTimeChanged: (dateTime) =>
                                //     setState(() {
                                //       startdate = dateTime
                                //     });),))

                                // },
                                // else if (Platform.isAndroid){
                                // DateTimePicker(
                                //     initialEntryMode:
                                //         DatePickerEntryMode.calendar,
                                //     timePickerEntryModeInput: true,
                                //     decoration: const InputDecoration(
                                //       labelText: 'Date and Time?',
                                //     ),
                                //     type: DateTimePickerType.dateTime,
                                //     use24HourFormat: false,
                                //     locale: const Locale('en', 'US'),
                                //     initialValue: lastdate.toString(),
                                //     firstDate: firstdate,
                                //     lastDate: DateTime.now(),
                                //     onChanged: (value) {
                                //       setState(() {
                                //         dateValue = value;
                                //       });
                                //     },
                                //     validator: (value) {
                                //       return null;
                                // }),

                                const Spacer(),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Location'),
                                  controller: riverController,
                                  enabled: false,
                                ),
                                const Spacer(flex: 5),

                                formDropdown(
                                    menuOptions: ['Rainbow', 'Brown'],
                                    valueChoice: fishSpeciesValue,
                                    fieldName: 'Species'),

                                const Spacer(),
                                formDropdown(
                                    menuOptions: [
                                      'Excellent',
                                      'Good',
                                      'Average',
                                      'Spent'
                                    ],
                                    valueChoice: fishConditionValue,
                                    fieldName: 'Condition'),
                                const Spacer(),
                                formDropdown(
                                    menuOptions: [
                                      'Kept',
                                      'Released',
                                    ],
                                    valueChoice: keptOrReleasedValue,
                                    fieldName: 'Kept or Released'),
                                const Spacer(),
                                numericTextField(
                                    chosenController: fishWeightController,
                                    fieldLabel: 'Weight? (kg)'),

                                const Spacer(flex: 5),

                                Formfield(
                                  fieldentry: 'Fly used ?',
                                  fieldController: flyUsedController,
                                ),
                                const Spacer(),

                                Formfield(
                                  fieldentry: 'Any notes ?',
                                  fieldController: anyNotesController,
                                ),
                                const Spacer(),
                                Row(children: <Widget>[
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                  height: 250,
                                                  child: Row(children: <Widget>[
                                                    const Spacer(),
                                                    GestureDetector(
                                                        onTap: () {
                                                          pickImage(ImageSource
                                                                  .camera)
                                                              .then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        child: SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Column(
                                                              children: const <Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color: Colors
                                                                      .teal,
                                                                  size: 70,
                                                                ),
                                                                Text('Camera'),
                                                              ],
                                                            ))),
                                                    const Spacer(),
                                                    GestureDetector(
                                                        onTap: () {
                                                          pickImage(ImageSource
                                                                  .gallery)
                                                              .then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        child: SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: Column(
                                                              children: const <Widget>[
                                                                Icon(
                                                                  Icons.image,
                                                                  color: Colors
                                                                      .teal,
                                                                  size: 70,
                                                                ),
                                                                Text('Gallery'),
                                                              ],
                                                            ))),
                                                    const Spacer(),
                                                  ]));
                                            });
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                      label: const Text('Add image?')),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: imageIsSubmitted == true
                                        ? Row(children: const <Widget>[
                                            // Icon(
                                            //   Icons.check,
                                            //   color: Colors.green,
                                            // ),
                                            Icon(
                                              Icons.photo,
                                              color: Colors.green,
                                            ),
                                          ])
                                        : null,
                                  ),
                                ]),

                                Platform.isIOS
                                    ? Spacer(flex: 6)
                                    : Spacer(flex: 3),
                                Center(
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => Colors.teal),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              final fishyBiz = TroutData(
                                                user: getUserUID(),
                                                date: dateValue == null
                                                    ? DateTime.now()
                                                    : DateTime.parse(dateValue),
                                                river: riverController.text,
                                                lat: widget.latLon.latitude,
                                                lon: widget.latLon.longitude,
                                                fishSpecies: fishSpeciesValue,
                                                fishCondition:
                                                    fishConditionValue,
                                                fishWeight:
                                                    fishWeightController.text,
                                                keptOrReleased:
                                                    keptOrReleasedValue,
                                                riverPool: poolController.text,
                                                flyUsed: flyUsedController.text,
                                                anyNotes:
                                                    anyNotesController.text,
                                                fishImage: imagepath,
                                              );
                                              const CircularProgressIndicator();

                                              clarity = newCatch(fishyBiz);
                                            });

                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/fishinglog',
                                                (route) => false);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Row(children: <Widget>[
                                              const Text('Nice Fish!'),
                                              const SizedBox(
                                                  height: 40, width: 10),
                                              SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: Image.asset(
                                                      'assets/images/trout.png',
                                                      color: Colors.white)),
                                            ])));
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                        ))),
                              ],
                            )))))
          ],
        )));
  }
}
