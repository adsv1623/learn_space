import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class helperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';


  // save data to shared preference
  static Future<bool> savedUserLoggedInPreference (bool isUserLoggedIn) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> savedUserNamePreference (String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey,userName );
  }

  static Future<bool> savedUserEmailPreference (String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  
  ///////////////////////////////////////////////////////////          get data from shared preference
  static Future<bool> getUserLoggedInPreference () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNamePreference () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailPreference () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserEmailKey);
  }

}