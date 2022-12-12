import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

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
    return Center(
        child: Form(
            key: _formKey,
            child: Container(
              color: Colors.teal.shade100,
              height: 400,
              margin: const EdgeInsets.fromLTRB(30, 5, 30, 70),
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(flex: 6),
                  Formfield(
                      fieldentry: 'Email',
                      fieldController: emailController,
                      isSensitiveData: false),
                  const Spacer(),
                  Formfield(
                    fieldentry: 'Password',
                    fieldController: passwordController,
                    isSensitiveData: true,
                  ),
                  const Spacer(),
                  // Row(
                  //   children: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () {
                        signIn();
                      },
                      icon: const Icon(Icons.lock_open, color: Colors.black),
                      label: const Text('Sign In',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal))),
                  const Spacer(),
                  TextButton(
                      // ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text.trim());
                      },
                      child: const Text('Forgot Password ?',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12))),
                  //   ],
                  // ),
                  const Spacer(flex: 3),
                ],
              ),
            )));
  }
}
