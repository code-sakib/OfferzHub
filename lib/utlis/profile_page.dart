import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/home_page.dart';
import 'package:offerzhub/utlis/screen_sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:offerzhub/core/globals.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: !isGuest
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                  )
                                ]),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                '${auth.currentUser?.photoURL}',
                              ),
                              radius: sizes(context).width / 7,
                            ),
                          )
                        : const Icon(
                            Icons.person_2_rounded,
                            size: 150,
                          )),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'User:                    ${auth.currentUser?.displayName ?? 'GuestUser'}',
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
                SizedBox(
                  height: sizes(context).height / 2,
                  child: const DefaultTabController(
                      length: 3,
                      child: TabBarView(children: [
                        Center(
                          child: Text('offers'),
                        ),
                        Center(
                          child: Text('rewards'),
                        ),
                        Center(
                          child: Text('settings'),
                        ),
                      ])),
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
                ExpansionTile(
                  title: const Text('Personal'),
                  shape: const OutlineInputBorder(borderSide: BorderSide.none),
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
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: const Text('About'),
                  shape: const OutlineInputBorder(borderSide: BorderSide.none),
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
                OutlinedButton(
                    onPressed: () {
                      isGuest = false;
                      auth.signOut();
                      GoogleSignIn().signOut();
                      context.goNamed('auth');
                      currentScreen.value = 0;
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

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});

  @override
  Widget build(BuildContext context) {
    final double prefSize = sizes(context).height / 4;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(prefSize),
              child: AppBar(
                toolbarHeight: 300,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isGuest
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                  )
                                ]),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                '${auth.currentUser?.photoURL}',
                              ),
                              radius: sizes(context).width / 7,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey),
                            child: const Icon(
                              Icons.person_2_rounded,
                              size: 80,
                            ),
                          ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              auth.currentUser?.displayName ?? 'GuestUser',
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
                  ],
                ),
                bottom: const TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.diversity_1_rounded),
                  ),
                  Tab(
                    icon: Icon(Icons.discount_rounded),
                  ),
                  Tab(
                    icon: Icon(Icons.info_outline_rounded),
                  )
                ]),
                actions: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          isGuest = false;
                          auth.signOut();
                          GoogleSignIn().signOut();
                          context.goNamed('auth');
                          currentScreen.value = 0;
                        },
                        icon: const Icon(Icons.logout_rounded)),
                  )
                ],
              )),
          body: const TabBarView(
              children: [Text("Offers"), Text("Rewards"), SettingsView()]),
        ));
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    title: Text("Share Offers"),
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    children: [
                      Text(
                          "The online offers which includes 'buy more and get off' like a offer which says 'if you buy 2 glasses get Rs.1000 off', so here find the other partner around you so that you could both save Rs.1000."),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    title: Text("Share Rewards"),
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    children: [
                      Text(
                        "Rewards you don't need like a gift card, food,watch,uber coupons which may expire, that you can trade here whilst grabbing the other rewards needed.",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.center,
                    title: const Text("Permissions"),
                    shape:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    children: [
                      Column(
                        children: [
                          Text.rich(
                            TextSpan(children: [
                              const TextSpan(
                                text: 'Location: ',
                              ),
                              TextSpan(
                                  text: serviceEnabled
                                      ? 'allowed '
                                      : 'not allowed',
                                  style: serviceEnabled
                                      ? const TextStyle(color: Colors.green)
                                      : TextStyle(color: Colors.red[200])),
                              TextSpan(
                                  text: serviceEnabled
                                      ? '(to show offers around location)'
                                      : '(allow this to show offers around location)',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10))
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    title: Text("FOUNDER"),
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    children: [
                      Text("Hii"),
                    ],
                  ),
                ),
                const Text(
                  "Version: 1.0.0",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> openAppSettings() async {
  final Uri settingsUri = Uri.parse('app-settings:');
  if (await canLaunchUrl(settingsUri)) {
    await launchUrl(settingsUri);
  } else {
    debugPrint('Could not open app settings.');
  }
}
