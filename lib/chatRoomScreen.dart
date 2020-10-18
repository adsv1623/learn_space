import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_space/module/Constant.dart';
import 'package:learn_space/services/database.dart';

// ignore: camel_case_types
class chatRoomScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String ChatRoomId;

  chatRoomScreen(this.ChatRoomId);

  @override
  _chatRoomScreenState createState() => _chatRoomScreenState();
}

// ignore: camel_case_types
class _chatRoomScreenState extends State<chatRoomScreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;

  // ignore: non_constant_identifier_names
  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return messageTile(
                  message: snapshot.data.documents[index].data()["message"],
                  isSendByMe: snapshot.data.documents[index].data()["sendBy"] ==
                      Constant.myName
              );
            }
        ) : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constant.myName,
        "time": DateTime
            .now()
            .microsecondsSinceEpoch,
      };
      _databaseMethods.addConversationMessage(widget.ChatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    _databaseMethods.getConversationMessage(widget.ChatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: AutoSizeText(
          "LearnSpace",
          style: GoogleFonts.getFont('Chilanka',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              backgroundColor: Colors.deepPurple),
        ),
      ),
      body: Stack(
        children: [
          ChatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.fromLTRB(30, 8, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: TextStyle(color: Colors.black87,),
                    decoration: InputDecoration(
                      fillColor: Color(0xF18273),
                      hintText: "Message...",
                      hintStyle: GoogleFonts.getFont(
                        'Montserrat', textStyle: TextStyle(
                      ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
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

// ignore: camel_case_types
class messageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  messageTile({this.message, this.isSendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery
          .of(context)
          .size
          .width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? [Color(0xff007EF4), Color(0xff2A75BC)] :
            [Color(0x1AFFFFFA), Color(0x3AFFFFFF)],
          ),
          borderRadius: isSendByMe ?
          BorderRadius.only(topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)) :
          BorderRadius.only(topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
    );
  }
}
