import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class chatRoomScreen extends StatefulWidget {
  @override
  _chatRoomScreenState createState() => _chatRoomScreenState();
}

class _chatRoomScreenState extends State<chatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          "LearnSpace",
          style: GoogleFonts.getFont(
            'Chilanka',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.fromLTRB(30, 8, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    //controller: searchTextEditingController,
                    style: TextStyle(color: Colors.black87,),
                    decoration: InputDecoration(
                      fillColor: Color(0xF18273),
                      hintText: "Message...",
                      hintStyle: GoogleFonts.getFont('Montserrat',textStyle:TextStyle(
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    //await initiateSearch();
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
                    child: Image.asset("Images/sendmessage.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
