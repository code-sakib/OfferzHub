// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

bool isGuest = false;

class AuthUI extends StatelessWidget {
  const AuthUI({super.key});
  static final introAnimationPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    introAnimationPageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  } else if (details.primaryVelocity! < 0) {
                    introAnimationPageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
                child: PageView(
                  controller: introAnimationPageController,
                  children: [_introAni1(context), _introAni2(), _introAni3()],
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: introAnimationPageController,
              count: 3,
              effect: const WormEffect(
                  activeDotColor: Colors.deepPurple,
                  dotHeight: 12,
                  dotWidth: 12),
            ),
            const SizedBox(height: 20),
            //Auth buttons
            ElevatedButton.icon(
              onPressed: () async {
                showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevent closing by tapping outside
                    builder: (context) => const CupertinoActivityIndicator());

                await AuthApi.signInWithGoogle(context);
              },
              icon: const Text(
                'Login with',
                style: TextStyle(color: Colors.white),
              ),
              label: Image.asset(
                'assets/general/google_logo.png',
                height: 50,
                width: 50,
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

                    context.goNamed('home');
                  },
                  icon: const Text(
                    'Login as Guest',
                    style: TextStyle(color: Colors.white),
                  ),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(
                      Icons.person_2_rounded,
                      color: Colors.grey,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _introAni1(context) {
  return const Column(
    children: [
      SizedBox(
        height: 50,
      ),
      LoadLottie(file: 'assets/ani/lottie_animation_1.json'),
      SizedBox(
        height: 20,
      ),
      Text(
        'Brands📣:',
        style: TextStyle(fontSize: 15),
      ),
      Text('We offer, "Buy more get more offers!"'),
    ],
  );
}

Widget _introAni2() {
  return const Column(
    children: [
      LoadLottie(file: 'assets/ani/lottie_animation_2.json'),
      Text(
          "Here users can team up with others to meet the offer's purchase threshold, unlocking discounts that would be otherwise unattainable for individual buyers."),
    ],
  );
}

Widget _introAni3() {
  return const LoadLottie(file: 'assets/ani/lottie_animation_3.json');
}

class LoadLottie extends StatefulWidget {
  const LoadLottie({super.key, required this.file});

  final String file;

  @override
  State<LoadLottie> createState() => _LoadLottieState();
}

class _LoadLottieState extends State<LoadLottie> {
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLoaded) const Center(child: CupertinoActivityIndicator()),
        Opacity(
          opacity: isLoaded ? 1 : 0,
          child: Lottie.asset(
            widget.file,
            onLoaded: (composition) {
              // Animation has finished loading
              setState(() {
                isLoaded = true;
              });
            },
          ),
        ),
      ],
    );
  }
}
