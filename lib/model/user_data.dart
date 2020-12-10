import 'package:flutter/material.dart';

class UserData {
  final String username;
  final String email;
  final String phone;
  final String imageURL;
  final String bio;

  UserData({
    this.username,
    this.email,
    this.phone,
    this.bio,
    this.imageURL,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : username = json['user']['username'],
        email = json['user']['email'],
        phone = json['phone'],
        bio = json['bio'],
        imageURL = json['avatar'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'phone': phone,
        'bio': bio,
        'imageURL': imageURL,
      };
}

class UserDataChangeNotifier extends ChangeNotifier {
  UserData userdata;
  onNewUserData(user) {
    this.userdata = user;
    notifyListeners();
  }

  UserData get getUserData {
    return this.userdata;
  }
}
