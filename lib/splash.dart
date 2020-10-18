import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learn_space/services/UserManagement.dart';
import 'package:learn_space/services/authServices.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    /*
    Below Check if User already Logged In or Not ?  Goto HomePage :  Goto OnStart Page
     */
     FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out! So Moved To OnStart Page From Splash Screen');
        Navigator.of(context).pushReplacementNamed('/OnStart');
      } else {
        print('User is Already signed in! So Moved To HomePage From Splash Screen');
        Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
        print('Current User UID : $user');
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
                opacity: 0.5,
                child: Image.asset('Images/bg.png')
            ),

            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Color(0xff7f00ff),
              highlightColor: Color(0xffe100ff),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "LearnSpace",
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                        shadows: <Shadow>[
                          Shadow(
                              blurRadius: 18.0,
                              color: Colors.black87,
                              offset: Offset.fromDirection(120, 12)
                          )
                        ]
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
