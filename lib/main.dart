import 'package:learn_space/SignUp.dart';
import 'package:learn_space/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/HomePage.dart';
import 'package:learn_space/Login.dart';
import 'package:learn_space/OnStart.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String,WidgetBuilder>{
        '/LandingPage' : (BuildContext context) => new MyApp(),  // On start Page
        '/SignUp':(BuildContext context) => new SignUp(),
        '/LoginPage': (BuildContext context) => new Login(),
        '/HomePage': (BuildContext context) => new MainCollapsingToolbar(),
        '/OnStart':  (BuildContext context) => new OnStart(),
      },
    );
  }
}



