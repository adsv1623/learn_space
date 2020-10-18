import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // upload user data
  uploadUserInfoToDatabase(userMap) {
    userCollection.add(userMap);
  }

  // get User data with Query
  getUserByUsername(String username) async {
    return await userCollection.where('name', isEqualTo: username).get();
  }

  getUserByUserEmail(String userEmail) async {
    return await userCollection.where('email', isEqualTo: userEmail).get();
  }

  // create Chat room
  createChatRoom(String chatRoomId, chatRoomMap) async {
    return await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print("error at database Page L21" + e.toString());
    });
  }

  //   ADD  conversation between two users
  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print("Error at Database getConversationMessage: " + e.toString());
    });
  }


  getConversationMessage(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats').orderBy("time", descending: false)
        .snapshots();
  }

  // Users Chat Rooms Past
  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance.collection('chatRoom').where(
        "users", arrayContains: userName).snapshots();
  }

}
