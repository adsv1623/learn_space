import 'package:flutter/material.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/services/UserManagement.dart';
import 'package:learn_space/services/authServices.dart';
import 'package:learn_space/services/database.dart';
import 'package:learn_space/services/helperFunctions.dart';

import 'Loading.dart';
import 'package:email_validator/email_validator.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Important Credential
  String _email;
  String _password;
  String _name;
  String _category;

// category
  List _categoryList =[ 'Student','Teacher','Parents','Staff'];
  String _categoryVal ;



  //  ///////////////////             Instances of Other
  final formKey = GlobalKey<FormState>();
  String dropValue;
  final dropChange = GlobalKey<FormFieldState>();
  AuthService authMethods = new AuthService();
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  // text Edit Controller
  TextEditingController userNameTextEditController = new TextEditingController();
  TextEditingController emailTextEditController = new TextEditingController();
  TextEditingController passwordTextEditController = new TextEditingController();

  //shows loading option while SignUp
  bool isLoading= false;

  /// SignMe Up   With Email And Password
  signMeUp(){
    if(formKey.currentState.validate()){
      Map<String,dynamic> userInfoMap ={
        'name': _name,
        'email': _email,
        'category':_category,
        'groups': [],
      };

      /////////////// shared Prefs
      helperFunctions.savedUserEmailPreference(_email);
      helperFunctions.savedUserNamePreference(_name);

      setState(() {
        isLoading= true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditController.text, passwordTextEditController.text).then((value){
        _category = _categoryVal;
        print("category is : "+ _category);
        _databaseMethods.uploadUserInfoToDatabase(userInfoMap);
        helperFunctions.savedUserLoggedInPreference(true);
        print(value.userId);
        Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
      }).catchError((e){
        print('error at SignUp Page L 47'+e.toString());
      });
    }
  }

  // Valid Email Or Not
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Images/L1.png'), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 50,
                        left: 20,
                        width: 150,
                        child: Container(
                          child: Text(
                            "Sign up Now!",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                letterSpacing: 2,
                                shadows: [
                                  Shadow(
                                      color: Colors.grey,
                                      blurRadius: 20,
                                      offset: Offset(0, 4))
                                ]),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Form(
                              key : formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                    child: TextFormField(
                                      validator: (val){
                                        if(val.isEmpty||val.length<2){
                                          return "Please Provide Username";
                                        }
                                        return null;
                                      },
                                      controller: userNameTextEditController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Username",
                                          hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.green),
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          _name = value.trim();
                                        });
                                      },
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 18),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 5,),
                                          decoration: BoxDecoration(
                                            //border: Border.all(color: Colors.black,width: 2),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: DropdownButton(
                                            focusColor: Colors.blueGrey,
                                            hint: Text("category",style: TextStyle(color: Colors.grey[500],fontSize: 18,)),
                                            dropdownColor: Colors.white,

                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 45,
                                            isExpanded: true,
                                            value: _categoryVal,
                                            style: TextStyle(color: Colors.black54,fontSize: 18,),
                                            onChanged: (value){
                                              setState(() {
                                                _categoryVal = value;
                                                _category= value;
                                              });
                                            },
                                            items: _categoryList.map((value){
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),


                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom:
                                            BorderSide(color: Colors.grey[100]))),
                                    child: TextFormField(
                                      validator: (val){
                                        if(!EmailValidator.validate(val)){
                                          return "enter a valid email address";
                                        }
                                        return null;
                                      },
                                      controller: emailTextEditController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.green),
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          _email = value.trim();
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator:  (val){
                                        if(val.length>=6 &&validateStructure(val) ){
                                          return null;
                                        }
                                        return "enter a valid password";
                                      },
                                      controller: passwordTextEditController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                          "Create Password (should be at least 6 digits with special char)",
                                          hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                          //focusColor: Colors.blue,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.green),
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          _password = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///           Sign Up Here  Submit
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                await signMeUp();
                              },
                              child: FadeAnimation(
                                2,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
