import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PageTwo.dart';
import 'SlideListView.dart';
import 'PageOne.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SlideListView(
          view1: PageOne(),//buildPage(Color(0xFFFF9000), "Page 1"0XFFbdbdbd),
          view2: PageTwo(),
          floatingActionButtonColor: Color(0xFFFF9000),
          floatingActionButtonIcon: AnimatedIcons.menu_arrow,
          showFloatingActionButton: true,
          defaultView: "slides",
          duration: Duration(
            milliseconds: 800,
          ),
        ),
      ),
    );
  }

  Container buildPage(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
