import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socially/model/user_data.dart';
import 'package:socially/networking.dart';

class DrawerScreen extends StatelessWidget {
  final NetworkHelper nh = NetworkHelper();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataChangeNotifier>(
      builder: (context, usernotify, child) {
        var user = usernotify.getUserData;

        return Container(
          color: Color(0xffd35d6e),
          padding: EdgeInsets.only(top: 30, left: 10, bottom: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      // CircleAvatar(
                      //   radius: 60,
                      //   backgroundImage: user.imageURL != null
                      //       ? NetworkImage(user.imageURL)
                      //       : null,
                      //   backgroundColor: Colors.transparent,
                      // ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username != null ? user.username : 'Username',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.email != null ? user.email : 'email',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.phone != null ? user.phone : 'contact',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 120),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.bio != null ? user.bio : 'write your bio',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(children: [
                        Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                        Text(
                          'Groups',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Icon(
                        Icons.note,
                        color: Colors.white,
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]),
        );
      },
    );
  }
}
