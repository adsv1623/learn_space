import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_space/HomePage.dart';
import 'package:learn_space/Login.dart';
class authservice{
  //Handle Auth
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return MainCollapsingToolbar();
        }else{
          return Login();
        }
      },
    );
  }
}