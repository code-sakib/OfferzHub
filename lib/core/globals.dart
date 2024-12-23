import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Firebase
final FirebaseFirestore firestore = FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;

//currentUser
late User currentUser;
//Getit
final getIt = GetIt.instance;

//Shared Preferences
// late final SharedPreferences gloabal_prefs;

//showIntro
bool? toShowOnBoarding;


//location services
late final String? userAdd;
late final bool serviceEnabled;
