import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OnStart extends StatefulWidget {
  @override
  _OnStartState createState() => _OnStartState();
}

class _OnStartState extends State<OnStart> {
  // Bottom Navigation Bar
  GlobalKey _bottomNavigationKey = GlobalKey();

  // Which Bottom Bar I 'm
  int _page = 0;
  int _prev = 0;

  // Quotes Showing ON Start Page
  List<Widget> lis = [
    //////////////////////////////////////////////////////////page 1  Head Top Left
    FadeAnimation(
      1,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeAnimation(
            2,
            Container(
              child: Center(
                child: AutoSizeText(
                  "LearnSpace", // Todo
                  maxLines: 1,
                  minFontSize: 22,
                  style: GoogleFonts.getFont(
                    'Chilanka',
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                            color: Colors.blueGrey[300],
                            blurRadius: 8,
                            offset: Offset(0, 6)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            2.9,
            Container(
              padding: EdgeInsets.all(10),
              child: AutoSizeText(
                "An Ultimate Education Space", //Todo
                maxLines: 1,
                minFontSize: 12,
                style: GoogleFonts.getFont(
                  'Indie Flower',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          offset: Offset(0, 4)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    //    ///////////////////////////////////////////          page 2
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FadeAnimation(
          1.6,
          Container(
            child: AutoSizeText(
              "LearnSpace :)", // Todo
              maxLines: 2,
              minFontSize: 20,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 45,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
        ),
        FadeAnimation(
          2,
          Container(
            margin: EdgeInsets.all(3),
            child: AutoSizeText(
              "Reach Your E-School", // Todo
              maxLines: 2,
              minFontSize: 20,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 4))
                  ]),
            ),
          ),
        ),
        FadeAnimation(
          2.5,
          Container(
            child: AutoSizeText(
              "Students ,Teachers & Parents at a Single Platform", // Todo
              maxLines: 2,
              minFontSize: 18,
              style: GoogleFonts.getFont(
                'Indie Flower',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                        color: Colors.grey,
                        blurRadius: 20,
                        offset: Offset(0, 4)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),

    ///////////////////////////////////////////              page 3
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAnimation(
          2,
          Container(
            //padding: EdgeInsets.fromLTRB(, top, right, bottom)
            child: AutoSizeText(
              "Provide Parents Control over his/her Child Educations", // Todo
              maxLines: 2,
              minFontSize: 12,
              style: GoogleFonts.getFont(
                'Indie Flower',
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                        color: Colors.grey,
                        blurRadius: 20,
                        offset: Offset(0, 4)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    /////////////////////////////////////////////////    Page 4
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeAnimation(
          2,
          Container(
            child: FadeAnimation(
              1,
              AutoSizeText(
                "Get Started Now!",
                maxLines: 1,
                minFontSize: 12,
                style: GoogleFonts.getFont(
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
          ),
        ),
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
                        image: AssetImage('Images/L1.png'), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 50,
                      left: 20,
                      width: 150,
                      height: 200,
                      child: FadeAnimation(
                        1,
                        Container(
                          child: AutoSizeText(
                            "Hi,\nWelcome",
                            style: GoogleFonts.getFont(
                              'Fredoka One',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                letterSpacing: 3,
                                shadows: [
                                  Shadow(
                                    color: Colors.grey[400],
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 20,
                      width: 350,
                      height: 230,
                      child: FadeAnimation(1.6, lis[_page]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(290, 180, 10, 30),
                child: FadeAnimation(
                  20,
                  Column(
                    children: <Widget>[
                      //Text(_page.toString(), textScaleFactor: 10.0),
                      RaisedButton(
                        color: Color(0xff5f65d5),
                        splashColor: Colors.white,
                        child: Text(
                          (_page == 0 || _page == 1 || _page == 2)
                              ? 'Skip'
                              : 'Get Started',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          //Page change using state does the same as clicking index 3 navigation button
                          final CurvedNavigationBarState navBarState =
                              _bottomNavigationKey.currentState;
                          navBarState.setPage(3);
                          if (_prev == 3) {
                            Navigator.of(context)
                                .pushReplacementNamed('/LoginPage');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      ///////////////////////////////////////////         Bottom Nav
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
          new Icon(
            Icons.adjust_outlined,
            size: 20,
            color: Colors.white,
          ),
          new Icon(
            Icons.adjust_outlined,
            size: 20,
            color: Colors.white,
          ),
          new Icon(
            Icons.adjust_outlined,
            size: 20,
            color: Colors.white,
          ),
          new Icon(
            Icons.adjust_outlined,
            size: 20,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _prev = _page;
            _page = index;
          });
        },
      ),
    );
  }
}
