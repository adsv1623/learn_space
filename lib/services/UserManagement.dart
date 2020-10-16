import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';


class UserManagement {
  StoreNewUserWithEmail(user,context) {
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

  StoreNewUserWithPhone(user,context){
    FirebaseFirestore.instance.collection('/users').add({
      'email':'',
      'uid': user.uid,
      'phone': user.phone,
    }).then((value){
      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (Route<dynamic> route) => false);
      print("ADDED NEW USER BRO WITH PHONE !");
    }).catchError((e) {
      print(e);
    });
  }
}