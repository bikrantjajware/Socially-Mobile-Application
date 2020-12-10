import 'package:flutter/material.dart';
import 'package:socially/widgets/login_form.dart';
import 'package:socially/widgets/signup_form.dart';

class Login extends StatefulWidget {
  static const id = 'login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRegistered = true;

  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Container(
                height: 200,
                child: Image.asset('images/socially_icon.png'),
              ),
            ),
            isRegistered ? LoginForm() : SignupForm(),
            FlatButton(
              onPressed: () {
                setState(() {
                  isRegistered = !isRegistered;
                });
              },
              child: isRegistered
                  ? Text(
                      "Don't have an account yet? Sign Up",
                      style: TextStyle(color: Colors.lightBlue),
                    )
                  : Text(
                      'Goto Login',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
