import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offerzhub/core/dependencies.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/core/routing.dart';
import 'package:offerzhub/core/theme.dart';
import 'package:offerzhub/features/offers/domain/domain_repo_impl.dart';
import 'package:offerzhub/features/offers/domain/provider/offers_provider.dart';
import 'package:offerzhub/firebase_options.dart';
import 'package:offerzhub/utlis/scroll_behaviour.dart';
import 'package:offerzhub/utlis/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });

  firestore
      .collection('chats')
      .doc('admin_user13')
      .update({'usersCurrentStatus.admin': 'online'});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          OffersProvider(getIt<DomainApiRepoImpl>())..performTask(),
      child: MaterialApp.router(
        theme: AppTheme.currentTheme,
        routerConfig: appRoutes,
        scaffoldMessengerKey: AppSnackBar.messengerKey,
        scrollBehavior: const ConstantScrollBehavior(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Future<void> uploadUsersToFirestore() async {
//   // Firestore reference for the document
//   final docRef = FirebaseFirestore.instance
//       .collection('users')
//       .doc('mUsers')
//       .collection('f')
//       .doc('Users');

//   // List of user data

//   try {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc('mUsers')
//         .collection('f')
//         .doc('Users')
//         .get()
//         .then((value) {
//       value.data()!.forEach((ca, a) {
//         fUsersList.add(a);
//       });
//     });

//     for (var user in fUsersList) {
//       String userId = user['userId']; // Extract userId
//       // Add user data to Firestore

//       await docRef.set({userId: user}, SetOptions(merge: true));

//       print("$userId added successfully!");
//     }
//   } catch (e) {
//     print("Error uploading users: $e");
//   }
// }

Future<void> uploadUsersToOffers() async {
  final finalOffersList = [];
  FirebaseFirestore.instance
      .collection('users')
      .doc('mUsers')
      .collection('f')
      .doc('Users')
      .get()
      .then((value) {
    value.data()!.forEach((ca, a) {
      fUsersList.add(a);
    });
  });
  FirebaseFirestore.instance
      .collection('users')
      .doc('mUsers')
      .collection('m')
      .doc('Users')
      .get()
      .then((value) {
    value.data()!.forEach((ca, a) {
      mUsersList.add(a);
    });
  });
  // Firestore reference for the document
  FirebaseFirestore.instance
      .collection('offers')
      .doc('companyUploaded')
      .get()
      .then((value) {
    value.data()!.forEach((k, v) {
      List alreadyContained = [];
      List userList = [];
      int i = 0;
      while (i < 5) {
        int a = Random().nextInt(fUsersList.length);
        !alreadyContained.contains(a)
            ? {userList.add(fUsersList[a]), userList.add(mUsersList[a]), i++}
            : null;
      }

      v['interestedUsers'] = userList;

      finalOffersList.add(v);

      try {
        ///Adding users
        // for (var offers in fUsersList) {
        //   String userId = user['userId']; // Extract userId
        //   // Add user data to Firestore

        //   await docRef.set({userId: user}, SetOptions(merge: true));

        //   print("$userId added successfully!");
        // }

        ///Modifying OFfers
        FirebaseFirestore.instance
            .collection('offers')
            .doc('companyUploaded')
            .set({k: v}, SetOptions(merge: true));

        // print('$k uploaded successfully');
      } catch (e) {
        // print("Error uploading users: $e");
      }

      // while (b != 0) {
      //   int f = Random().nextInt(fUsersList.length);
      //   if (!alreadyContained.contains(f)) {
      //     alreadyContained.add(f);

      //     g.addEntries(fUsersList[f].entries);
      //     b--;
      //   }
      // }
    });
  });

  // List of user data
}

List<Map<String, dynamic>> fUsersList = [];
List<Map<String, dynamic>> mUsersList = [];
List<Map<String, dynamic>> offersList = [];
