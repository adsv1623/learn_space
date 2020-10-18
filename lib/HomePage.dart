import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_space/chatRoomScreen.dart';
import 'package:learn_space/module/Constant.dart';
import 'package:learn_space/new/courses.dart';
import 'package:learn_space/new/recently.dart';
import 'package:learn_space/services/authServices.dart';
import 'package:learn_space/services/database.dart';
import 'package:learn_space/services/helperFunctions.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class MainCollapsingToolbar extends StatefulWidget {
  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {
  final _controller = TextEditingController();
  AuthService authMethods = new AuthService();
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return chatRoomTile(
                      snapshot.data.documents[index]
                          .data()["chatroomId"]
                          .toString()
                          .replaceAll('_', "")
                          .replaceAll(Constant.myName, ""),
                      snapshot.data.documents[index].data()["chatroomId"]);
                })
            : Container();
      },
    );
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          authMethods.signOut().then((value) {
            Navigator.of(context).pushReplacementNamed('/LoginPage');
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

  //courses Default Todo
  final List _title = ["Science", "Chemistry", "Maths", "Biology"];

  final List _images = [
    "Images/crl1.jpeg",
    "Images/crl2.jpeg",
    "Images/crl3.jpeg",
    "Images/crl4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
        //Fab list
          fabButtons: <Widget>[
            float2(),
            float1(),
          ],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
      resizeToAvoidBottomPadding: true,
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.deepPurple,
                  expandedHeight: 220.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: AutoSizeText("LearnSpace",
                          style: GoogleFonts.getFont("Dancing Script",
                              textStyle: TextStyle(
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
                      )),
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
                        new Tab(icon: Icon(Icons.bolt), text: "Chats"),
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
                Container(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(45),
                                bottomRight: Radius.circular(45),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                        "Images/bg.jpg",
                                      ),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 108,
                                      ),
                                      AutoSizeText(
                                        "Your Learning Guide...",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.getFont('Lemonada',
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                letterSpacing: 1.9,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "Study subject",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 20,
                                            letterSpacing: 1.9,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 30.0,
                            ),
                          ]),
                          margin: EdgeInsets.only(
                              top: 16.0, left: 16.0, right: 16.0),
                          height: 62,
                          child: new TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    right: 4.0, top: 2, bottom: 2, left: 2.0),
                                child: SizedBox(
                                  width: 64.0,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      color: Color(0xffeef1f3),
                                      onPressed: () {
                                        // Todo For cards
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                      )),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                              hintText: 'Search... ',
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600),
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "All Subjects",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 1.9,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 210,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _title.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return CourseCard(
                                  _title[index], "60", _images[index]);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Recently Viewed",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 1.9,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Recently();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: chatRoomList(),
                ),
                Center(
                  // ////////////////////////////////////// Notice Tab
                  child: Text(
                    " Notice Board",
                    style: TextStyle(color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                ),
                Center(
                  child: Padding(
                    ////////////////////////////////////////  Contact Us Tab
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: AutoSizeText("Team Amigos\n Contact Us...",
                        style: TextStyle(color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 36),
                      ),
                    ),

                  ),
                ),
              ],
            )),
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
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
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

// chat room
// ignore: camel_case_types
class chatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  chatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => chatRoomScreen(chatRoomId)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.black12],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),

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
              child: Text(
                '${userName.substring(0, 1).toUpperCase()}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
