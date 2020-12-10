import 'package:flutter/material.dart';
import 'package:socially/model/user_data.dart';
import 'package:socially/model/post_data.dart';
import 'package:socially/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:socially/screens/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return UserDataChangeNotifier();
        }),
        ChangeNotifierProvider(create: (context) {
          return Posts();
        }),
      ],
      child: MaterialApp(
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => Login(),
          Profile.id: (context) => Profile(),
        },
      ),
    );
  }
}
