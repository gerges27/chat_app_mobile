import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get user streams
  Stream<List<Map<String, dynamic>>> getUsers() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
}
