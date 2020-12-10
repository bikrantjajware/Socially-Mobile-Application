import 'package:flutter/material.dart';
import 'package:socially/model/user_data.dart';

class Post {
  int postID;
  String title;
  String message;
  int groupID;
  String username;
  DateTime updateTime;
  Post(
      {this.postID,
      this.title,
      this.message,
      this.groupID,
      this.username,
      this.updateTime});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        postID: json['id'],
        groupID: json['group'],
        title: json['title'],
        message: json['message'],
        username: json['username'],
        updateTime: DateTime.parse(json['updated_at']));
  }

  Map<String, dynamic> toJson() => {
        'id': postID,
        'title': title,
        'message': message,
        'group': groupID,
        'username': username,
        'updated_at': updateTime,
      };
}

class Posts extends ChangeNotifier {
  List<Post> allpost = [];

  onPostInitialize(postlist) {
    this.allpost = postlist;
    notifyListeners();
  }
}
