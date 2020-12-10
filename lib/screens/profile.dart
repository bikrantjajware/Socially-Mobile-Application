import 'package:flutter/material.dart';
import 'package:socially/screens/drawer_screen.dart';
import 'package:socially/screens/home_screen.dart';

class Profile extends StatelessWidget {
  static const id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DrawerScreen(),
        HomeScreen(),
      ]),
    );
  }
}
