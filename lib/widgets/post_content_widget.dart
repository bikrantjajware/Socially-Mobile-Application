import 'package:flutter/material.dart';

class PostContentWidget extends StatelessWidget {
  const PostContentWidget({
    Key key,
    @required this.now,
  }) : super(key: key);

  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Text(
                'this is post title',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?"),
            Text('~by lorem ipsum'),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              ]),
              Column(
                children: [
                  Text(
                    'updated: ${now.hour}:${now.minute}:${now.second}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'created: ${now.hour}:${now.minute}:${now.second}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
