import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function callLogin;
  final String text;
  RoundedButton({this.callLogin, this.text});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(30),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: callLogin,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
