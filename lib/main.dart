import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offerzhub/core/dependencies.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/core/routing.dart';
import 'package:offerzhub/features/offers/domain/domain_repo_impl.dart';
import 'package:offerzhub/features/offers/domain/provider/offers_provider.dart';
import 'package:offerzhub/firebase_options.dart';
import 'package:offerzhub/utlis/scroll_behaviour.dart';
import 'package:offerzhub/utlis/snackbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
  List n = [
    'Yaseer',
    'Ahmad',
    'John',
    'Josh',
    'Yakub',
    'Rohan',
    'Amit',
    'Lana',
    'Mike',
    'Rosh',
    'Tyson',
  ];

  List im = [
    'https://images.pexels.com/photos/29137971/pexels-photo-29137971/free-photo-of-scenic-autumn-pathway-lined-with-vibrant-leaves.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
    'https://i.pinimg.com/736x/f3/31/3a/f3313a03e0c4c69fda4f5e01037e8966.jpg',
    'https://i.pinimg.com/736x/fe/1d/bf/fe1dbf5af17ca70896bc3ad711d3854f.jpg',
    'https://e1.pxfuel.com/desktop-wallpaper/903/679/desktop-wallpaper-97-aesthetic-best-profile-pic-for-instagram-for-boy-instagram-dp-boys.jpg',
    'https://images.pexels.com/photos/1322543/pexels-photo-1322543.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBgfm2dNSerjbutKiv9sPCq_N2OMwFVct-AA&s',
    'https://www.shutterstock.com/image-photo/some-indian-nature-random-clicks-260nw-1439293076.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOXP3L49XatBdQfafKzQr31SY-6BVvBzONrw&s'
  ];

  final Map<String, dynamic> d = {};

  for (var i = 0; i < n.length; i++) {
    final image = i < 8 ? im[i] : null;
    d.addEntries({
      'user$i': {'name': n[i], 'img': image, 'offerU': '', 'rewardU': ''}
    }.entries);
  }
  firestore.collection('users').doc('madeUsers').set(d);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          OffersProvider(getIt<DomainApiRepoImpl>())..performTask(),
      child: MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: true),
        routerConfig: appRoutes,
        scaffoldMessengerKey: AppSnackBar.messengerKey,
        scrollBehavior: const ConstantScrollBehavior(),
      ),
    );
  }
}

// Future<void> signInAnonymously() async {
//   try {
//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInAnonymously();
//     String uid = userCredential.user?.uid ?? '';
//     print("Signed in anonymously, UID: $uid");
//   } on FirebaseAuthException catch (e) {
//     print("Error: ${e.message}");
//   }
//}
