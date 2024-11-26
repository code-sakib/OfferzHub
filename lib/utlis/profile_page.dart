import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/utlis/screen_sizes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = sizes(context).height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  auth.currentUser?.photoURL ?? 'assets/profile/general.png',
                  height: height / 5,
                )),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'User:                    ${auth.currentUser?.displayName ?? 'Astranaut'}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: const Text('Your uploads'),
                    children: [
                      Text('Rewards:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                      const Text('..soon'),
                      Text('Offers:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                      const Text('..soon'),
                    ],
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    title: const Text('Personal'),
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      Text(
                        '(after the thorough review of the company users get verified.)',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                          'Email: ${!isGuest ? auth.currentUser?.email : 'guestUser'} '),
                      GestureDetector(
                          child: const Text('Profile status: Verified')),
                    ],
                  ),
                ),
                Card(
                  child: ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: const Text('About'),
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      Text('Share rewards:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                      const Text(
                        "Rewards you don't need like a gift card, food,watch,uber coupons which may expire, that you can trade here whilst grabbing the other rewards needed.",
                      ),
                      Text('Share offers:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                      const Text(
                          "The online offers which includes 'buy more and get off' like a offer which says 'if you buy 2 glasses get Rs.1000 off', so here find the other partner around you so that you could both save Rs.1000."),
                      Text('Offers nearby',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w700)),
                      const Text(
                          'If you go for a shopping of jeans, with this map feature find the shops around you that has some offers regarding jeans that helps you grab the best deal. '),
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      isGuest = false;
                      GoogleSignIn().signOut();
                      auth.signOut();
                    },
                    child: const Text("Logout"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
