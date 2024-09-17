import 'package:chat_app/chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // get user streams
  Stream<List<Map<String, dynamic>>> getUsers() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //Send message....
  Future<void> sendMessage(String receiveID, message) async {
    // get current user info
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //  create new msg
    Message newMessage = Message(
      sendedId: currentUserId,
      senderEmail: currentUserEmail,
      receiverID: receiveID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users
    List<String> ids = [currentUserId, receiveID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new messages to dataBase
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUsersID) {
    List<String> ids = [userID, otherUsersID];
    ids.sort();

    String chatRoomID = ids.join('_');

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
