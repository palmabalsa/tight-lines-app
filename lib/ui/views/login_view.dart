import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/registration_form.dart';
import 'package:ttlines2/ui/widgets/sign_in_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late TabController loginTabController;

  @override
  void initState() {
    super.initState();
    loginTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    loginTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(
            'Turangi Tight Lines',
            style: theme.textTheme.headline5,
          ),
          const Spacer(flex: 2),
          SizedBox(
            height: 40,
            width: 50,
            child: Image.asset('assets/images/trout.png', color: Colors.white),
          ),
          const Spacer(flex: 6),
        ]),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          height: 500,
          margin: const EdgeInsets.fromLTRB(30, 5, 30, 70),
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              TabBar(controller: loginTabController, tabs: const <Widget>[
                Tab(text: 'Sign In'),
                Tab(text: 'Register'),
              ]),
              SizedBox(
                  height: 400,
                  child: TabBarView(
                      controller: loginTabController,
                      children: const <Widget>[
                        SignInForm(),
                        RegistrationForm(),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
