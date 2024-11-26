import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/core/routing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DopeIntro extends StatefulWidget {
  const DopeIntro({super.key});

  static final listOfPages = [introPage1(), introPage2()];

  static int currentPage = 0;

  static final pageController = PageController();

  @override
  State<DopeIntro> createState() => _DopeIntroState();
}

class _DopeIntroState extends State<DopeIntro> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gloabal_prefs.setBool('toShowIntro', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              controller: DopeIntro.pageController,
              children: [introPage1(), introPage2(), introPage3()],
            ),

            //dot indicators
            Container(
                alignment: const Alignment(0.0, 0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () => context.goNamed('auth'),
                        child: const Text("skip")),
                    SmoothPageIndicator(
                      controller: DopeIntro.pageController,
                      count: 3,
                      effect: const WormEffect(
                          activeDotColor: Colors.deepPurple,
                          dotHeight: 12,
                          dotWidth: 12),
                    ),
                    TextButton(
                        onPressed: () {
                          DopeIntro.pageController.page == 2.0
                              ? DopeIntro.pageController.jumpTo(1)
                              : DopeIntro.pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                        },
                        child: const Text("next")),
                  ],
                )),
          ],
        ));
  }
}

Widget introPage1() {
  return Container(
    color: Colors.black,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '''There are so many offers out there''',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Lottie.asset('assets/general/dope_intro1_animation.json')),
      ],
    ),
  );
}

Widget introPage2() {
  return Container(
    color: Colors.black,
    child: const Center(
        child: Text(
      '''Let's groupbuy them with Offermates.''',
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.start,
    )),
  );
}

Widget introPage3() {
  gloabal_prefs.setBool('toShowIntro', false);
  return Container(
    color: Colors.black,
    child: const Center(
        child: Text(
      '''Also you can sell your unused/useless 
  coupons and can find best ongoing 
    offers around your location here''',
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.start,
    )),
  );
}
