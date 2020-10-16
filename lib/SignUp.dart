import 'package:flutter/material.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/services/UserManagement.dart';

import 'Loading.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //added
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  //Phone auth
  String phoneNo;
  String smsCode;
  String verificationId;

  Future<void> verifyPhone() async{
    print("////////////////Here VerifyPhone Starts////////\n");
    print("Phone No :${this.phoneNo} ");
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      this.verificationId = verId;
      smsCodeDialog(context).then((value){
        print('Signed in With OTP');
        Navigator.pop(context);
      }).catchError((e){
        Navigator.of(context).pop();
        showDialog(
            context:  context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return new AlertDialog(
                title: Text('Failed - Try Again',style: TextStyle(fontFamily: 'pacifico',fontSize:10,fontWeight: FontWeight.bold ),),
                content: Text('${e.message}'),
                contentPadding: EdgeInsets.all(10.0),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
                      },
                      child:
                      Text('Try Again',style: TextStyle(color: Colors.redAccent[200],),))
                ],
              );
            }
        );
      });
    };

    final PhoneVerificationCompleted verifiedSucces = (AuthCredential authRes){
      print('verified');
      FirebaseAuth.instance.signInWithCredential(authRes).catchError((e){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
        print("///////////Error at PhoneVerification////////////");
      });
    };

    final PhoneVerificationFailed verifiedFalied = (FirebaseAuthException  authRes){
      print("//////////////////////////////// Failed Phone Verification Bro /////////////////////");
      Navigator.of(context).pop();
      showDialog(
        context:  context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Failed - Try Again',style: TextStyle(fontFamily: 'pacifico',fontSize:10,fontWeight: FontWeight.bold ),),
            content: Text('${authRes.message==null? 'Try After Sometime\nLater': authRes.message}'),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
                  },
                  child:
                  Text('Try Again',style: TextStyle(color: Colors.redAccent[200],),))
            ],
          );
        }
      );
      print('${authRes.message}');
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        verificationCompleted: verifiedSucces,
        verificationFailed: verifiedFalied,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: const Duration(seconds: 5),
    ).catchError((e){
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
      print("///////////Error at verifyPhoneNumber////////////");

    });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();// Here
                  },
                  child:
                  Text('Done'))
            ],
          );
        });
  }
  //End Phone auth

  String _email;
  String _password;
  String _phone;
  String _name;
  bool disableEmail = true;
  // Validate
  TextEditingController userNameController = TextEditingController();
  bool isName= false;
  bool isEmail=false;
  bool isPassword= false;
  bool isPhone= false;

  bool validateTextField(String userInput,int field) {
    if (userInput.isEmpty) {
      setState(() {
        if(field==0) isEmail=true;
        else if(field==1) isPassword = true;
        else if(field==2) isPhone = true;
      });
      return false;
    }
    setState(() {
      if(field==0) isEmail=false;
      else if(field==1) isPassword = false;
      else if(field==2) isPhone = false;
    });
    return true;
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
                        image: AssetImage('Images/L1.png'), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 50,
                        left: 20,
                        width: 150,
                        height: 200,
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
                padding: EdgeInsets.all(20.0),
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
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[100]))),
                              child: TextField(
                                //enabled: disableEmail,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorText: isEmail ? 'Please enter a Username' : null,
                                  //focusColor: Colors.blue,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )
                                ),
                                onChanged: (value) {
                                  setState(() {
                                       //disableEmail = true;
                                      _email = value.trim();
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                //enabled: disableEmail,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Create Password (should be at least 6 digits)",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    //focusColor: Colors.blue,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),
                                    )
                                ),
                                onChanged: (value) {
                                  setState(() {
                                     //disableEmail = false;
                                    _password = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text("OR",style: TextStyle(color: Colors.grey[400]),),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    //focusColor: Colors.blue,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),
                                    )
                                ),
                                onChanged: (value) {
                                  setState(() {
                                      _phone = value;
                                     this.phoneNo = value;
                                  });
                                },
                              ),
                            ),
                                                       ///           Sign Up Here  Submit
                            SizedBox(height: 30,),
                            InkWell(
                              onTap: () async {
                                try {
                                  if(_email==null) {
                                    await verifyPhone();
                                    if(FirebaseAuth.instance.currentUser != null){
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacementNamed('/HomePage');
                                    }else{
                                      //Navigator.of(context).pop();
                                      _handleSubmit(context);
                                    }
                                  }else
                                  final newUser = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                      email: _email, password: _password).then((
                                      signedInUser) {
                                    UserManagement().StoreNewUserWithEmail(
                                        signedInUser.user, context);
                                  });
                                } on FirebaseAuthException catch(e){
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print('The account already exists for that email.');
                                  }
                                } catch(e){
                                   print(e);
                                 }
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
                                  child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

  Future<void> SignInWithPhone() async {
    final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential).then((user){
      UserManagement().StoreNewUserWithPhone(_phone, context);
    }).catchError((e){
      print(e);
    });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      await SignInWithPhone();
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
      //Navigator.pushReplacementNamed(context, "/home");
    } catch (error) {
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      print(error);
    }
  }


}




