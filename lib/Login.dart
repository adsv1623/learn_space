import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:learn_space/services/authServices.dart';
import 'package:learn_space/services/database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';
import 'package:learn_space/services/helperFunctions.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email ;
  String _password;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditController = new TextEditingController();
  TextEditingController passwordTextEditController = new TextEditingController();
  AuthService _authService = new AuthService();
  DatabaseMethods _databaseMethods = new DatabaseMethods();


  // Valid Email Or Not
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isLoading = false;
  QuerySnapshot _snapshotUserInfo;

  loginMeUp(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      _databaseMethods.getUserByUserEmail(_email).then((value){
        _snapshotUserInfo = value;
        helperFunctions.savedUserNamePreference(_snapshotUserInfo.docs[0].data()['name']);  // Todo Fault Occur may be
      });
      _authService.signInWithEmailAndPassword(_email, _password).then((value) {
        if(value!=null){
          helperFunctions.savedUserLoggedInPreference(true);
          Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', (route) => false);
        }
      }).catchError((e) {
        Alert(
            title: "Incorrect Details",
            context: context,
            desc: "Email or Password doesn't Match",
            buttons: [
              DialogButton(
                  child: Text("Try Again"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]).show();
        print("error at Login L45: " + e.toString());
      });
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Images/L1.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Images/L2.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.3, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Images/L3.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Images/L4.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: AutoSizeText("Login",
                              maxLines: 1,
                              style:  GoogleFonts.getFont(
                                'Source Code Pro',
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  shadows: [
                                    Shadow(
                                        color: Colors.deepPurple[300],
                                        blurRadius: 8,
                                        offset: Offset(0, 8))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                    ),
                                    child: TextFormField(
                                      controller: emailTextEditController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                      ),
                                      validator: (val){
                                        if(!EmailValidator.validate(val)){
                                          return "enter a valid email address";
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        setState(() {
                                          _email = value;
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
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                      ),
                                      obscureText: true,
                                      onChanged: (value){
                                        setState(() {
                                          _password = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                      // Login
                      SizedBox(height: 30,),
                      InkWell(
                        onTap: () async {
                          //Working  Login  with Email & Password
                          await loginMeUp();

                        },
                        child: FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        ),
                      ),

                      //    Sign Up
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('/SignUp');
                        },
                        child: FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                            child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        ),
                      ),

                      Shimmer.fromColors(
                        period: Duration(milliseconds: 1500),
                        baseColor: Color(0xff4285F4),
                        highlightColor: Color(0xffDB4437),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "G-SignIn",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Piedra',
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
                      ),

                      //SizedBox(height: 70,),
                      Container(
                          alignment: Alignment.centerRight,
                          child: FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1),fontWeight: FontWeight.bold),),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


