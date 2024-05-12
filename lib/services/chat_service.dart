import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vdoc/modles/message.dart';

class ChatService {

  // Get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get User stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        //go through each individual user
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }


  // Send Message
  Future<void> sendMessage(String receiverID, message) async {

    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp
    );


    // construct chat room ID for the wo users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the IDs (this ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');


    // add new massage to database
    await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());
  }


    // get Messages
    Stream<QuerySnapshot> getMessages (String userID, otherUserID) {
      // construct a chatroom ID for two users
      List<String> ids = [userID, otherUserID];
      ids.sort();
      String chatRoomID = ids.join('_');

      return _firestore
          .collection("chat_rooms")
          .doc(chatRoomID)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots();
    }



}