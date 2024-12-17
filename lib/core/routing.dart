import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/features/chat/chat_screen.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';
import 'package:offerzhub/features/offers/presentation/detail_offerview.dart';
import 'package:offerzhub/features/offers/presentation/offers_page.dart';
import 'package:offerzhub/home_page.dart';
import 'package:offerzhub/utlis/profile_page.dart';
import 'package:offerzhub/utlis/snackbar.dart';
import 'package:page_transition/page_transition.dart';

bool showLoginMsg = true;

final GoRouter appRoutes = GoRouter(routes: [
  GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) =>
          _buildPageWithTransition(state, const HomePage()),
      routes: [
        GoRoute(
            path: 'offerDetail',
            name: 'offerDetail',
            pageBuilder: (context, state) {
              final Map<OffersModel, int> s =
                  state.extra as Map<OffersModel, int>;
              return _buildPageWithTransition(
                  state,
                  DetailedOfferView(
                      offersModel: s.keys.first, i: s.values.first));
            })
      ]),
  GoRoute(
      path: '/',
      name: 'auth',
      builder: (context, state) {
        return Scaffold(
          body: StreamBuilder(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (isGuest) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                    AppSnackBar.showSnackBar('Logged in as guest.'));
                return const HomePage();
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (snapshot.hasData) {
                  currentUser = auth.currentUser!;

                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                      AppSnackBar.showSnackBar('Login Successful.'));
                  showLoginMsg = false;

                  return const HomePage();
                } else if (!snapshot.hasData) {
                  return const AuthUI();
                } else if (snapshot.hasError) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                      AppSnackBar.showSnackBar(snapshot.error,
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
      path: '/offers',
      name: 'offers',
      pageBuilder: (context, state) =>
          _buildPageWithTransition(state, const OffersPage())),
  GoRoute(
    path: '/profile',
    name: 'profile',
    builder: (context, state) => const ProfilePage(),
  ),
  GoRoute(
      path: '/chat',
      name: 'chat',
      pageBuilder: (context, state) => _buildPageWithTransition(
            state,
            isGuest
                ? GuestChatScreen(user: state.extra as UserModel)
                : ChatScreen(
                    user: state.extra as UserModel,
                  ),
          ))
]);

// Helper function to apply transitions globally
Page<void> _buildPageWithTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        child: child,
        duration: const Duration(milliseconds: 300),
      ).buildTransitions(context, animation, secondaryAnimation, child);
    },
  );
}
