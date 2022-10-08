import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/form_fields.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future registerUser() async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushNamed(context, '/fishinglog');
      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                fieldController: _emailController,
                isSensitiveData: false,
              ),
              const Spacer(),
              Formfield(
                fieldentry: 'Password',
                fieldController: _passwordController,
                isSensitiveData: true,
              ),
              const Spacer(),
              ElevatedButton.icon(
                  onPressed: () {
                    registerUser();
                  },
                  icon: const Icon(
                    Icons.person_add,
                    color: Colors.black,
                  ),
                  label: const Text('Register',
                      style: TextStyle(color: Colors.black))),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
