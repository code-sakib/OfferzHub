import 'package:cloud_firestore/cloud_firestore.dart';

String getTime(Timestamp tS) {
  // Example Firestore Timestamp

  // Convert Firestore Timestamp to DateTime
  DateTime dateTime = tS.toDate();

  // Extract time parts
  String hours = dateTime.hour.toString().padLeft(2, '0'); // Ensure 2 digits
  String minutes = dateTime.minute.toString().padLeft(2, '0');

  // Combine into a formatted string
  String formattedTime = "$hours:$minutes";

  return formattedTime;
}
