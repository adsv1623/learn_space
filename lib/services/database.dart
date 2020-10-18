import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  // Collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  // upload user data
  uploadUserInfoToDatabase(userMap){
    userCollection.add(userMap);
  }

  // get User data with Query
  getUserByUsername(String username) async {
    return await userCollection.where('name',isEqualTo: username).get();
  }

  getUserByUserEmail(String userEmail) async {
    return await userCollection.where('email',isEqualTo: userEmail).get();
  }

  // create Chat room
  createChatRoom(String chatRoomId, chatRoomMap) async {
    return await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).set(chatRoomMap).catchError((e){
      print("error at database Page L21"+e.toString());
    });
  }

  //conversation between two users
  getConversationMessage(String chatRoomId){
    
  }

}