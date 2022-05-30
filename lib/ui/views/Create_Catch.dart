import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/views/troutDataLog.dart';
// import 'package:ttlines2/ui/widgets/dropdown_form_fields.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

class NewCatchView extends StatefulWidget {
  const NewCatchView({ Key? key,}) : super(key: key);

  @override
  State<NewCatchView> createState() => _NewCatchViewState();
}
class _NewCatchViewState extends State<NewCatchView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 Future<TroutData>? clarity;

  TextEditingController riverpoolController = TextEditingController();
  TextEditingController flyusedController = TextEditingController();
  TextEditingController anynotesController = TextEditingController();
  // TextEditingController fishweightController = TextEditingController();

  // String? riverValue;
  // String? fishspeciesValue;
  // String? fishconditionValue;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text( 'FISHING LOG', style: theme.textTheme.headline5,),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget> [
            
              Formfield(fieldentry: 'River pool', fieldController: riverpoolController),
              Formfield(fieldentry: 'Fly used', fieldController: flyusedController),
              Formfield(fieldentry: 'Any notes', fieldController: anynotesController),
              // Formfield(fieldentry: 'Fish weight', fieldController: fishweightController),

              // CustomDropdown(choicesList: ['Tongariro', 'Tauranga Taupo', 'Lake OMG']),
              // CustomDropdown(choicesList: ['Rainbow', 'Brown']),
              // CustomDropdown(choicesList: ['Sashimi','Healthy','Average','Sick/Spawning',]),
             

              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()){

                    setState(() {
                      final fishyBiz = TroutData(
                        river_pool: riverpoolController.text, 
                        fly_used: flyusedController.text, 
                        any_notes: anynotesController.text,
                        // fish_weight: fishweightController.text,

                        // river : riverValue,
                        // fish_species :  fishspeciesValue,
                        // fish_condition : fishconditionValue,
                        );
                       clarity = newCatch(fishyBiz); 
                    }
                    
                    );
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TroutDataView()),
                  );
                  }
                }, 
                child: const Text('Submit')
              ),




            ],)
        )

      )
      
    );
  }
}