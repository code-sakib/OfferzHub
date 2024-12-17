// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/utlis/snackbar.dart';

class AuthApi {
  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com').onError((e, s) {
        throw FirebaseException(plugin: '', message: 'No Internet 😐');
      }); // Perform the asynchronous operation
      // Trigger the sign-in flow using Google Sign In
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().onError(
        (error, stackTrace) {
          throw FirebaseException(plugin: error.toString());
        },
      );

      // Check if user cancelled the sign-in
      if (googleUser != null) {
        // Obtain the authentication results from the Google Sign-in activity
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a credential from the Google Sign-in credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with Firebase using the credential

        await auth.signInWithCredential(credential);
        isGuest = false;
      }
    } on FirebaseException catch (err) {
      AppSnackBar.showSnackBar(err.message.toString(), colorGreen: false);
    } finally {
      // Dismiss the loading dialog
      context.pop();
    }
  }
}
