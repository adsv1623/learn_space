import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_space/module/Constant.dart';
import 'package:learn_space/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;

  Widget searchList(){
    if(searchSnapshot!=null){
      return ListView.builder(
        shrinkWrap: true,
        itemCount:  searchSnapshot.docs.length,
        itemBuilder: (context,index){
          return searchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"] ,
            userCategory: searchSnapshot.docs[index].data()["category"],
          ) ;
        },
      );
    }
    print("user is null comming");
    return Container();
  }


  initiateSearch(){
      _databaseMethods.getUserByUsername(searchTextEditingController.text).then((value){
      setState(() {
        searchSnapshot = value;
        //print(searchSnapshot);
      });
    });
  }


  // Message chat room Create a chat room And Send Message to searched User
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarOpacity: 0.5,
        title:AutoSizeText(
          "LearnSpace",
          style: GoogleFonts.getFont('Chilanka',fontWeight: FontWeight.bold,fontSize: 20,),
        ),
      ),

      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 8, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.black87,),
                      decoration: InputDecoration(
                        fillColor: Color(0xF18273),
                        hintText: "Search",
                        hintStyle: GoogleFonts.getFont('Montserrat',textStyle:TextStyle(
                        ),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await initiateSearch();
                    },
                    child: Container(
                      height: 40,
                        width: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFF),
                              Color(0x0FFFFFFFF),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Image.asset("Images/search.png"),
                    ),
                  ),
                ],
              ),
            ),
              searchList(),
          ],
        ),
      ),
    );
  }
}
createChatRoomAndStartConversation(BuildContext context, String userName){
  if(userName!=Constant.myName){
    String chatRoomId = getChatRoomId(Constant.myName,userName);
    List<String> users = [Constant.myName,userName];
    Map<String,dynamic> chatRoomMap ={
      "users" : users,
      "chatroomId": chatRoomId
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.of(context).pushReplacementNamed('/chatRoomScreen');
  }
}



// ignore: camel_case_types
class searchTile extends StatelessWidget {
  final String userName ;
  final String userEmail;
  final String userCategory;
  // constructor
  searchTile({this.userName,this.userEmail,this.userCategory});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,style: TextStyle(color: Colors.grey[700], fontSize:15,fontWeight: FontWeight.bold ),),
              Text(userCategory,style: TextStyle(color: Colors.grey[600], ), ),
              Text(userEmail,style: TextStyle(color: Colors.grey[600], ), ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(context,userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Text("message",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}

getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0) ){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}