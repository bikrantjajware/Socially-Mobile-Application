import 'package:flutter/cupertino.dart';
import 'package:socially/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:socially/constants.dart';
import 'package:socially/utilities.dart';
import 'package:email_validator/email_validator.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupformkey = GlobalKey<FormState>();

  String username, email, password1, password2;

  FocusNode _usernameFocus = FocusNode();

  FocusNode _emailFocus = FocusNode();

  FocusNode _password1Focus = FocusNode();

  FocusNode _password2Focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _signupformkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autofocus: true,
              focusNode: _usernameFocus,
              onSaved: (value) {
                username = value;
              },
              validator: (name) {
                Pattern pattern = r'^[A-Za-z0-9]+(?:[_][A-Za-z0-9]+)*$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(name)) return 'Invalid Name';

                return null;
              },
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              onFieldSubmitted: (_) {
                fieldFocusChange(context, _usernameFocus, _emailFocus);
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                fieldFocusChange(context, _emailFocus, _password1Focus);
              },
              onSaved: (value) {
                email = value;
              },
              validator: (email) => EmailValidator.validate(email)
                  ? null
                  : "Invalid Email Address",
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _password1Focus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                fieldFocusChange(context, _password1Focus, _password2Focus);
              },
              obscureText: true,
              onSaved: (value) {
                password1 = value;
              },
              validator: (pass1) {
                Pattern pattern =
                    r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(pass1)) return 'Invalid password';

                return null;
              },
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _password2Focus,
              textInputAction: TextInputAction.done,
              obscureText: true,
              onSaved: (value) {
                password2 = value;
              },
              validator: (pass2) {
                Pattern pattern =
                    r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(pass2))
                  return 'Invalid Password';
                else if (password1 != password2) return 'Password Mismatch';

                return null;
              },
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Confirm Password'),
            ),
            SizedBox(
              height: 30,
            ),
            RoundedButton(
              callLogin: () {
                if (_signupformkey.currentState.validate()) {
                  _signupformkey.currentState.save();
                }
              },
              text: 'Sign up',
            )
          ],
        ),
      ),
    );
  }
}
