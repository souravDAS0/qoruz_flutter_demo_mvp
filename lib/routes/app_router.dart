import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/influencer/influencer_profile_screen.dart';
import '../screens/campaign/campaign_list_screen.dart';
import '../screens/campaign/campaign_create_screen.dart';
import '../screens/profile/user_profile_screen.dart';

/// App routes
class AppRoutes {
  static const String splash = '/';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String influencerProfile = '/influencer/:id';
  static const String campaigns = '/campaigns';
  static const String campaignCreate = '/campaigns/create';
  static const String profile = '/profile';
}

/// App router configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) {
          final role = state.uri.queryParameters['role'];
          return SignupScreen(userRole: role);
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.influencerProfile,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: InfluencerProfileScreen(influencerId: id),
            transitionDuration: const Duration(milliseconds: 800),
            reverseTransitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.campaigns,
        builder: (context, state) => const CampaignListScreen(),
      ),
      GoRoute(
        path: AppRoutes.campaignCreate,
        builder: (context, state) => const CampaignCreateScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const UserProfileScreen(),
      ),
    ],
  );
}
