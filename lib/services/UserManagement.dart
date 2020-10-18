import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


class UserManagement {
  StoreNewUserWithEmail(User user,BuildContext context) {
    FirebaseFirestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'phone': '',
    }).then((value) {
      //Navigator.of(context).pop(); // Login Remove
      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (Route<dynamic> route) => false);
      print("ADDED NEW USER BRO !");
    }).catchError((e) {
      print(e);
    });
  }

  StoreNewUserWithPhone(User user,BuildContext context){
    FirebaseFirestore.instance.collection('/users').add({
      'email':'',
      'uid': user.uid,
      'phone': user.phoneNumber,
    }).then((value){
      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (Route<dynamic> route) => false);
      print("ADDED NEW USER BRO WITH PHONE !");
    }).catchError((e) {
      print(e);
    });
  }
}