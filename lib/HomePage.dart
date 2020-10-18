import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_space/chatRoomScreen.dart';
import 'package:learn_space/module/Constant.dart';
import 'package:learn_space/services/authServices.dart';
import 'package:learn_space/module/Constant.dart';
import 'package:learn_space/services/database.dart';
import 'package:learn_space/services/helperFunctions.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class MainCollapsingToolbar extends StatefulWidget {
  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {
  AuthService authMethods = new AuthService();
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return chatRoomTile(
                  snapshot.data.documents[index].data()["chatroomId"]
                      .toString()
                      .replaceAll('_', "")
                      .replaceAll(Constant.myName, ""),
                  snapshot.data.documents[index].data()["chatroomId"]
              );
            }
        ) : Container();
      },
    );
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          authMethods.signOut().then((value) {
            Navigator.of(context).pushReplacementNamed(
                '/LoginPage');
          }).catchError((e) {
            print(e);
          });
        },
        tooltip: 'Logout',
        child: Icon(Icons.logout),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          Navigator.of(context).pushNamed('/SearchPage');
        },
        tooltip: 'Chat',
        child: Icon(Icons.chat),
      ),
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constant.myName = await helperFunctions.getUserNamePreference();
    _databaseMethods.getChatRooms(Constant.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });

    print("AT HOmePAge : L26: " + Constant.myName);
  }

  final List _images =[
    "Images/b1.jpg",
    "Images/b2.jpg",
    "Images/b3.jpg",
    "Images/b4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[
            float1(), float2()
          ],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
      resizeToAvoidBottomPadding: true,
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.deepPurple,
                  expandedHeight: 220.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: AutoSizeText("LearnSpace",
                          style: GoogleFonts.getFont(
                              "Dancing Script", textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ))),
                      background: Swiper(
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Image.asset(
                              _images[index],
                              fit: BoxFit.cover,
                            ),
                        autoplay: true,
                      )
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      onTap: (index) {
                        print(index);
                      },
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.cyanAccent[50],
                      tabs: [
                        new Tab(icon: Icon(Icons.home), text: "Home"),
                        new Tab(icon: Icon(Icons.bolt), text: "Guide"),
                        new Tab(
                            icon: Icon(Icons.notifications), text: "Notice"),
                        new Tab(icon: Icon(Icons.help), text: "Help"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("hii welcome"),
                    Text("ohoo again welcome"),
                  ],
                ),
                Center(
                  child: chatRoomList(),
                ),
                Center(
                  child: Text(" Tab 3 Content", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                ),
                Center(
                  child: Text(" Tab 4 Content", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
                ),

              ],
            )
        ),
      ),

    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.deepPurple,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}


class chatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  chatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => chatRoomScreen(chatRoomId)),);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: Colors.white54,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),

              ),
              child: Text('${userName.substring(0, 1).toUpperCase()}',
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
            ),
            SizedBox(width: 8,),
            Text(
              userName, style: TextStyle(fontSize: 20, color: Colors.black),),
          ],
        ),
      ),
    );
  }
}


