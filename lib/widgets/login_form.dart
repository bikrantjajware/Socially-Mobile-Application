import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socially/screens/profile.dart';
import 'package:socially/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:socially/constants.dart';
import 'package:socially/model/user_data.dart';
import 'package:socially/networking.dart';
import 'package:socially/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String name, pass;
  final _loginformKey = GlobalKey<FormState>();

  NetworkHelper nh = NetworkHelper();
  Future<String> getToken(username, password) async {
    var tokenData;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      tokenData = await nh.getToken(username, password);
    } catch (e) {
      print(e);
    }
    prefs.setString('token', 'abcd');
    return tokenData['token'];
  }

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Consumer<UserDataChangeNotifier>(builder: (context, userdata, child) {
        return Form(
          key: _loginformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                focusNode: _usernameFocusNode,
                autofocus: true,
                textInputAction: TextInputAction.next,
                validator: (name) {
                  Pattern pattern = r'^[A-Za-z0-9]+(?:[_][A-Za-z0-9]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(name)) return 'Invalid Name';

                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
                onFieldSubmitted: (_) {
                  fieldFocusChange(
                      context, _usernameFocusNode, _passwordFocusNode);
                },
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Username'),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                focusNode: _passwordFocusNode,
                onSaved: (password) {
                  pass = password;
                },
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.lock),
                ),
                validator: (password) {
                  Pattern pattern =
                      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(password)) return 'Invalid password';

                  return null;
                },
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                callLogin: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (_loginformKey.currentState.validate()) {
                    try {
                      _loginformKey.currentState.save();

                      String tkn = await getToken(name, pass);
                      print('token= $tkn');
                      await prefs.setString('token', tkn);
                      var user = await nh.getLoginData(tkn);
                      userdata.onNewUserData(user);
                      _loginformKey.currentState.reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                text: 'Login',
              )
            ],
          ),
        );
      }),
    );
  }
}
