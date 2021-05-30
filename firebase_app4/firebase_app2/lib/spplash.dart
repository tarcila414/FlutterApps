import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class Spplash extends StatefulWidget {
  static String tag = "/spplash";

  @override
  _Spplash createState() => _Spplash();
}

class _Spplash extends State<Spplash> with SingleTickerProviderStateMixin{
  double value = 100;

  AnimationController controller;
  Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =  AnimationController(vsync: this, duration: Duration(seconds: 2));
    sizeAnimation = Tween<double>(begin: 20.0, end: 100.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 5,
            gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ Color(0xffED213A), Color(0xff93291E)],
            ),
            navigateAfterSeconds: "/home2",
            loaderColor: Colors.transparent,
        ),
        Center(
           child: AnimatedContainer(
              duration: Duration(milliseconds: 20),
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              child: Image.asset("images/logo.png"),
              color: Colors.white,
            )
        ),
      ],
    );;
  }

  run() {
    setState(() {
      if (this.value == 100) {
        this.value = 300;
      } else {
        this.value = 100;
      }
    });
  }

}

