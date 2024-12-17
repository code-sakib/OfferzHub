import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:offerzhub/features/offers/presentation/offers_page.dart';
import 'package:offerzhub/utlis/profile_page.dart';
import 'package:toast/toast.dart';

ValueNotifier<int> currentScreen = ValueNotifier<int>(0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  final List listOfScreens = [
    // RewardsPage(),
    const OffersPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: listOfScreens[currentScreen.value],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: GNav(
                selectedIndex: 0,
                backgroundColor: Colors.black87,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(15),
                tabs: [
                  // GButton(
                  //   icon: Icons.discount_rounded,
                  //   text: ' share rewards',
                  //   onPressed: () {
                  //     setState(() {
                  //       currentScreen.value = 0;
                  //     });
                  //   },
                  // ),
                  GButton(
                    icon: Icons.diversity_1_rounded,
                    text: ' share offers',
                    onPressed: () {
                      setState(() {
                        currentScreen.value = 0;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.person_2_rounded,
                    text: ' Profile',
                    onPressed: () {
                      setState(() {
                        currentScreen.value = 1;
                      });
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
