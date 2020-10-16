import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learn_space/FadedAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainCollapsingToolbar extends StatefulWidget {
  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {

  final List _images =[
    "Images/b1.jpg",
    "Images/b2.jpg",
    "Images/b3.jpg",
    "Images/b4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color.fromRGBO(143, 148, 251, .6),
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Build My Money",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )),
                      background: Swiper(
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) => Image.asset(
                          _images[index],
                          fit: BoxFit.cover,
                        ),
                        autoplay: true,
                      )
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      onTap: (index){
                        print(index);
                      },
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.cyanAccent[50],
                      tabs: [
                        new Tab(icon: Icon(Icons.home),text: "Home"),
                        new Tab(icon: Icon(Icons.bolt), text: "Guide"),
                        new Tab(icon: Icon(Icons.help), text: "Help"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                Center(
                  child:
                  Center(
                    child: InkWell(
                      onTap: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.of(context).pushReplacementNamed('/LandingPage');
                        }).catchError((e){
                          print(e);
                        });
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
                          child: Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      ),
                    ),
                  ),//Text(" Tab 1 Content",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Center(
                  child: Text(" Tab 2 Content",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                Center(
                  child: Text(" Tab 3 Content",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                )
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

