import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/FadedAnimation.dart';

class OnStart extends StatefulWidget {
  @override
  _OnStartState createState() => _OnStartState();
}

class _OnStartState extends State<OnStart> {
  //State class
  int _page = 0;
  int _prev=0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  // Start Page Quotes
  List<Widget> lis = [
    //page 1
    FadeAnimation(1,
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        FadeAnimation(1,
        Container(
          //padding: EdgeInsets.fromLTRB(, top, right, bottom)
          child: Text("How do you go about building your net worth?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 10,offset: Offset(0,4))]),),
        ),),

        FadeAnimation(2.9,Container(
          padding: EdgeInsets.all(10),
          child: Text("It can be as easy as looking at your phone—literally",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 20,offset: Offset(0,4))]),),
        ),),

      ],
    ),),

    // page 2
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:[
        FadeAnimation(1.6,
        Container(
          //padding: EdgeInsets.fromLTRB(20, 80, 20,50),
          child: Text("We can help you track your spending, investments, and debt",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 5,offset: Offset(0,4))]),),
        ),),

        FadeAnimation(2,
        Container(
          margin: EdgeInsets.all(3),
          child: Text("In order to help you develop healthy spending habits",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 10,offset: Offset(0,4))]),),
        ),),
        FadeAnimation(2.5,
        Container(
          child: Text("that ultimately increase your net worth over time",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 20,offset: Offset(0,4))]),),
        ),),
      ],
    ),

    //page 3
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        FadeAnimation(2,
        Container(
          //padding: EdgeInsets.fromLTRB(, top, right, bottom)
          child: Text("Make your money work for you",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 20,offset: Offset(0,4))]),),
        ),),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        FadeAnimation(2,
        Container(
          //padding: EdgeInsets.fromLTRB(, top, right, bottom)
          child: Text("Get Started Now !",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,letterSpacing: 2,shadows:[Shadow(color: Colors.deepPurple[300],blurRadius: 20,offset: Offset(0,4))]),),
        ),),
      ],
    ),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Images/L1.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget> [
                      Positioned(
                        top: 50,
                        left: 20,
                        width: 150,
                        height: 200,
                        child: FadeAnimation(1,Container(
                          child: Text("Hi,\nWelcome", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 2,shadows:[Shadow(color: Colors.grey,blurRadius: 20,offset: Offset(0,4))]),),
                        )),
                      ),
                      Positioned(
                          top: 150,
                          left: 20,
                          width: 350,
                          height: 230,
                          child: FadeAnimation(1.6,lis[_page]),
                      ),


                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(290,180, 10,30),

                  child: FadeAnimation(20, Column(
                    children: <Widget>[
                      //Text(_page.toString(), textScaleFactor: 10.0),
                      RaisedButton(
                        color: Color(0xff5f65d5),
                        splashColor: Colors.white,
                        child: Text( (_page==0||_page==1||_page==2)?'Skip':'Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        onPressed: () {
                          //Page change using state does the same as clicking index 3 navigation button

                          final CurvedNavigationBarState navBarState =
                              _bottomNavigationKey.currentState;
                          navBarState.setPage(3);
                          if(_prev==3){
                            Navigator.of(context).pushReplacementNamed('/LoginPage');
                          }
                        },
                      ),
                    ],
                  ),),
                ),
                
              ],
              
            ),
            
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          key: _bottomNavigationKey,
          color: Color(0xff5f65d5),
          backgroundColor: Colors.white,
          animationDuration: Duration(
            milliseconds: 350,
          ),
          index: 0,
          animationCurve: Curves.bounceInOut,
        items: <Widget>[
          new Icon(Icons.adjust_outlined ,size: 20,color: Colors.white,),
          new Icon(Icons.adjust_outlined ,size: 20,color: Colors.white,),
          new Icon(Icons.adjust_outlined ,size: 20,color: Colors.white,),
          new Icon(Icons.adjust_outlined ,size: 20,color: Colors.white,),

        ],
          onTap: (index){
            setState(() {
              _prev= _page;
              _page = index;

            });
          },
    ),
    );
  }
}


