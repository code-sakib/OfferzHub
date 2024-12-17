import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  Timestamp timestamp;
  String senderId;
  String receiverId;
  MessageModel({
    required this.message,
    required this.timestamp,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'timestamp': timestamp,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
