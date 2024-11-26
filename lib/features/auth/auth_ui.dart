import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:offerzhub/core/globals.dart';

bool isGuest = false;

class AuthUI extends StatelessWidget {
  const AuthUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
            ColorizeAnimatedText('OfferzHub',
                colors: [
                  Colors.white,
                  const Color.fromARGB(255, 226, 101, 92),
                  const Color.fromARGB(255, 120, 83, 184)
                ],
                textStyle: const TextStyle(fontSize: 60)),
          ]),
          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
            TyperAnimatedText(
              'Whole new way of grabbing offers around',
              textStyle: const TextStyle(color: Colors.white),
            ),
          ]),
          const SizedBox(
            height: 80,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                // await AuthApi.signInWithGoogle();
              },
              icon: const Text('Login with'),
              label: Image.asset(
                'assets/general/google_logo.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: ElevatedButton.icon(
                onPressed: () async {
                  isGuest = true;
                  await auth.signOut();
                },
                icon: const Text('Login as Guest'),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.person_2_rounded),
                )),
          )
        ],
      ),
    );
  }
}
