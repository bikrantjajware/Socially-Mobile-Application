import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/networking.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socially/model/post_data.dart';
import 'package:socially/model/post_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  NetworkHelper nh = NetworkHelper();
  Future getPostData() async {
    String token;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
    } catch (e) {
      print(e);
    }
    print('token =  $token');
    var data = await nh.getAllPosts(token);
    return data;
  }

  var posts;
  DateTime now = DateTime.now();
  bool isDrawerOpen = false;
  @override
  void initState() {
    // TODO: implement initState
    posts = getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.only(top: 15),
      transform: Matrix4.translationValues(xoffset, yoffset, 0.0)
        ..scale(scalefactor),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: isDrawerOpen ? BorderRadius.circular(30) : null,
      ),
      child: ClipRRect(
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(30) : BorderRadius.circular(0),
        child: FutureBuilder(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const CircularProgressIndicator();
              else
                return Consumer<Posts>(builder: (context, posts, child) {
                  posts.onPostInitialize(snapshot.data);
                  List<Post> postList = posts.allpost;

                  return Column(
                    children: [
                      Row(children: [
                        isDrawerOpen
                            ? IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 30,
                                ),
                                onPressed: () {
                                  getPostData();
                                  setState(() {
                                    xoffset = 0;
                                    yoffset = 0;
                                    scalefactor = 1;
                                    isDrawerOpen = false;
                                  });
                                })
                            : IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    xoffset = 300;
                                    yoffset = 150;
                                    scalefactor = 0.6;
                                    isDrawerOpen = true;
                                  });
                                },
                              ),
                      ]),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (postList.isEmpty)
                            return Text(
                              'No posts',
                              style: TextStyle(fontSize: 20),
                            );
                          DateTime time = postList[index].updateTime;
                          return Card(
                            elevation: 16,
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 15),
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        postList[index].title,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      postList[index].message,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {}),
                                          ]),
                                          Column(
                                            children: [
                                              Text(
                                                  '~${postList[index].username}'),
                                              Text(
                                                'updated: ${time.hour}:${time.minute}:${time.second}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ],
                                )),
                          );
                        },
                        itemCount: postList.length,
                      )),
                    ],
                  );
                });
            }),
      ),
    );
  }
}
