import 'package:flutter/material.dart';
import 'package:ttlines2/ui/widgets/RegistrationForm.dart';
import 'package:ttlines2/ui/widgets/SignInForm.dart';

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
          Spacer(flex: 2),
          Container(
            height: 40,
            width: 50,
            child: Image.asset('assets/images/trout.png', color: Colors.white),
          ),
          Spacer(flex: 6),
        ]),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 500,
          margin: EdgeInsets.fromLTRB(30, 5, 30, 70),
          padding: EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              TabBar(controller: loginTabController, tabs: <Widget>[
                Tab(text: 'Sign In'),
                Tab(text: 'Register'),
              ]),
              Container(
                  height: 400,
                  child: TabBarView(
                      controller: loginTabController,
                      children: <Widget>[
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
