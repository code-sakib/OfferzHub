import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';
import 'package:offerzhub/features/offers/presentation/detail_offerview.dart';
import 'package:offerzhub/home_page.dart';
import 'package:offerzhub/utlis/dope_intro.dart';
import 'package:offerzhub/utlis/profile_page.dart';
import 'package:offerzhub/utlis/snackbar.dart';

bool showLoginMsg = true;

final GoRouter appRoutes = GoRouter(routes: [
  GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
            path: 'offerDetail',
            name: 'offerDetail',
            builder: (context, state) {
              final Map<OffersModel, int> s =
                  state.extra as Map<OffersModel, int>;
              return DetailedOfferView(
                  offersModel: s.keys.first, i: s.values.first);
            })
      ]),
  GoRoute(
      path: '/',
      name: 'auth',
      builder: (context, state) {
        bool? toShowIntro = gloabal_prefs.getBool('toShowIntro');
        print(toShowIntro);
        return toShowIntro == null || toShowIntro != null
            ? const DopeIntro()
            : Scaffold(
                body: StreamBuilder(
                  stream: auth.authStateChanges(),
                  builder: (context, snapshot) {
                    if (isGuest) {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) =>
                              AppSnackBar.showSnackBar('Logged in as guest.'));
                      return const HomePage();
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        if (showLoginMsg) {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) => AppSnackBar.showSnackBar(
                                  'Login Successful.'));
                          showLoginMsg = false;
                        }

                        return const HomePage();
                      } else if (!snapshot.hasData) {
                        return const AuthUI();
                      } else if (snapshot.hasError) {
                        WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) => AppSnackBar.showSnackBar(
                                snapshot.error,
                                colorGreen: false));
                        return const AuthUI();
                      } else {
                        return const AuthUI();
                      }
                    }
                  },
                ),
              );
      }),
  GoRoute(
      path: '/rewards',
      name: 'rewards',
      builder: (context, state) {
        // final key = state.extra as GlobalKey<ScaffoldState>;
        return Container(); //RewardsPage;
      }),
  GoRoute(
    path: '/profile',
    name: 'profile',
    builder: (context, state) => const ProfilePage(),
  ),
]);
