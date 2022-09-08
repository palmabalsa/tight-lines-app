import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/services/trout_data_api.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushNamed(context, '/fishinglog');
      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
        child: Form(
            key: _formKey,
            child: Container(
              color: Colors.teal.shade100,
              height: 400,
              margin: EdgeInsets.fromLTRB(30, 5, 30, 70),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 6),
                  Formfield(
                      fieldentry: 'Email', fieldController: emailController),
                  Spacer(),
                  Formfield(
                      fieldentry: 'Password',
                      fieldController: passwordController),
                  Spacer(),
                  ElevatedButton.icon(
                      onPressed: () {
                        signIn();
                      },
                      icon: Icon(Icons.lock_open, color: Colors.black),
                      label: Text('Sign In',
                          style: TextStyle(color: Colors.black))),
                  Spacer(flex: 3),
                ],
              ),
            )));
  }
}
