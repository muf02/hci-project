import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_ink_well/image_ink_well.dart';
import './restLoginPage.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'OrderGIK',
          style: TextStyle(
            color: Colors.orange[400],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        leading: Icon(Icons.restaurant),
      ),
      body: Mywidget(),
    );
  }
}

class Mywidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(60, 30, 0, 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: RoundedRectangleImageInkWell(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RestLogin()));
                },
                width: 300,
                height: 150,
                borderRadius: BorderRadius.all(const Radius.circular(20)),
                image: AssetImage('assets/17.jpg'),
              )),
              Container(
                  child: RoundedRectangleImageInkWell(
                onPressed: () {},
                width: 300,
                height: 150,
                borderRadius: BorderRadius.all(const Radius.circular(20)),
                image: AssetImage('assets/18.jpg'),
              )),
            ]));
  }
}