import 'package:http/http.dart';
import 'dart:convert';
import 'model/post_data.dart';

import 'model/user_data.dart';

const String loginURL = 'http://192.168.43.185:8000/api/accounts/login';
const String tokenURL = 'http://192.168.43.185:8000/api/accounts/token';
const String postsURL = 'http://192.168.43.185:8000/api/posts/all';

class NetworkHelper {
  Future getAllPosts(token) async {
    Response response =
        await get(postsURL, headers: {'Authorization': 'token $token'});
    if (response.statusCode == 200) {
      String data = response.body;

      var posts =
          jsonDecode(data).map<Post>((data) => Post.fromJson(data)).toList();
      return posts;
    } else {
      print(response.statusCode);
    }
  }

  Future getToken(String username, String password) async {
    Response response = await post(tokenURL,
        body: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      String data = response.body;
      var tokenData = jsonDecode(data);

      return tokenData;
    } else {
      print('token response = ${response.statusCode}');
    }
  }

  Future getLoginData(String token) async {
    Response response =
        await get(loginURL, headers: {'Authorization': 'token $token'});

    if (response.statusCode == 200) {
      String data = response.body;
      try {
        Map userdatamap = jsonDecode(data);
        var user = UserData.fromJson(userdatamap);
        //print('user= ${user.username}');
        return user;
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }
}
