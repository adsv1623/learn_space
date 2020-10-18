import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/HomePage.dart';
import 'package:learn_space/Login.dart';
import 'package:learn_space/module/userData.dart';
import 'UserManagement.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // return user Uid
  userData _userFromfirebaseUser(User user){
    return user!=null ? userData(userId:user.uid ): null;
  }


  //Handle Auth  Already Logged In Or Not
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot) {
        if (snapshot.hasData) {
          return MainCollapsingToolbar();
        } else {
          return Login();
        }
      },
    );
  }


  //Email & Password SignUp
  Future<String> CreateUserWithEmailAndPassword(
      String _email, String _password, String _name,BuildContext context) async {
    final currentUser =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    ).then((signInUser) async {
      // Store In Database
          print('Here : ${signInUser.user}');
         await UserManagement().StoreNewUserWithEmail(
              FirebaseAuth.instance.currentUser, context);
        }).catchError((e){
          print("Error at adding User !");
        });

    //Update User Name
    User firebaseUser = currentUser.user;
    await firebaseUser.updateProfile(displayName: _name, photoURL: null);
    await firebaseUser.reload();
    // return user uid
    return firebaseUser.uid;
  }

  // Sign In with Email & Password
  Future signInWithEmailAndPassword(String _email, String _password) async {
       try{
          UserCredential result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
          User firebaseUser = result.user;
          return _userFromfirebaseUser(firebaseUser);
       }catch(e){
         print('Error At authService L69 :  '+e.toString());
       }
  }

  //SignUp
  Future signUpWithEmailAndPassword(String _email,String _password) async{
    try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        User firebaseUser = result.user;
        return _userFromfirebaseUser(firebaseUser);
    }catch(e){
      print('Error At authService L75 :  '+e.toString());
    }
  }

  /// reset Password
  Future resetPassword(String _email)async{
    try{
        return await _auth.sendPasswordResetEmail(email: _email);
    }catch(e){
      print('Error At authService L75 :  '+e.toString());
    }
  }

// SignOut
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print('Error At authService L96 :  '+e.toString());
    }
  }
}
