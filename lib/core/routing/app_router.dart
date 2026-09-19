import 'package:go_router/go_router.dart';
import 'package:docdoc/core/routing/route_names.dart';
import 'package:docdoc/features/splash/splash_screen.dart';
import 'package:docdoc/features/onboarding/onboarding_screen.dart';
import 'package:docdoc/features/blank/blank_view.dart';
import 'package:docdoc/features/sign_in/presentation/view/sign_in_view.dart';
import 'package:docdoc/features/sign_up/presentation/views/sign_up_view.dart';
import 'package:docdoc/features/home/presentation/view/home_view.dart';
import 'package:docdoc/features/profile/presentation/view/profile_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    // Always start at splash — it decides where to go
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.signIn,
        name: 'signIn',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: RouteNames.signUp,
        name: 'signUp',
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RouteNames.blankView,
        name: 'blankView',
        builder: (context, state) => const BlankView(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: 'profile',
        builder: (context, state) => const ProfileView(),
      ),
    ],
  );
}