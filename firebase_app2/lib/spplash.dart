import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  static String tag = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _userNotLoginIn = false;
  @override
  initState() {
    User  currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null)
    {
      _userNotLoginIn = true;
    } else {
      FirebaseFirestore.instance
             .collection("usuarios")
             .where("id", isEqualTo: currentUser.uid)
             .get()
             .then((QuerySnapshot result) =>{
//           // _animationController.reset(),
               Navigator.pushReplacementNamed(
                 context,
                 '/home'
                 )})
             .catchError((err) => print("Erro"+err));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
              children: <Widget>[ Text("Loading")]
          )
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:loading/indicator/ball_pulse_indicator.dart';
// import 'package:loading/loading.dart';
// import 'home.dart';
//
// class SplashPage extends StatefulWidget {
//   SplashPage({Key key}) : super(key: key);
//   static String tag = '/spplash';
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage>{
//   // var _colorTween;
//   // var _animationController;
//   @override
//   initState() {
//     // _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
//     // _colorTween = _animationController.drive(
//     //     ColorTween(
//     //       begin: Colors.pinkAccent,
//     //       end: Colors.pink
//     //     )
//     // );
//     // _animationController.repeat();
//
//     User  currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//
//       Navigator.pushReplacementNamed(context, "/login");
//     } else {
//       // _animationController.reset();
//       FirebaseFirestore.instance
//             .collection("usuarios")
//             .where("id", isEqualTo: currentUser.uid)
//             .get()
//             .then((QuerySnapshot result) =>{
//           // _animationController.reset(),
//               Navigator.pushReplacementNamed(
//                 context,
//                 '/home'
//                 )})
//             .catchError((err) => print(err));
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: Text("Loading..."),
//         ),
//       ),
//     );
//   }
//
//
// }