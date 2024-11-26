// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:offerzhub/core/constants.dart';


// class AuthApi {
//   static Future<UserCredential?> signInWithGoogle() async {
//     // Trigger the sign-in flow using Google Sign In
//     final GoogleSignInAccount? googleUser = await GoogleSignIn(
//         clientId:
//             '576270923723-9c8ttd0f5fn40vg7p0k8nao0hrpcphi9.apps.googleusercontent.com')
//       .signIn();

//     // Check if user cancelled the sign-in
//     if (googleUser != null) {
//       // Obtain the authentication results from the Google Sign-in activity
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Create a credential from the Google Sign-in credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in with Firebase using the credential

//       await auth.signInWithCredential(credential);

//       if (gloabal_prefs.getString('firestoreId') == null) {
//         gloabal_prefs.setString('firestoreId', fireStoreAuoId());
//         await firestore
//             .collection('users')
//             .doc(gloabal_prefs.getString('firestoreid'))
//             .set({
//           'Email': auth.currentUser!.email,
//           'DisplayName': auth.currentUser!.displayName,
//           'uid': auth.currentUser!.uid,
//         });
//       }
//     } else {
//       return null;
//     }
//     return null;
//   }
// }
