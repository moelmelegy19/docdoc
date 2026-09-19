import 'package:go_router/go_router.dart';
import 'package:docdoc/core/routing/route_names.dart';
import 'package:docdoc/features/onboarding/onboarding_screen.dart';
import 'package:docdoc/features/blank/blank_view.dart';
import 'package:docdoc/features/sign_in/presentation/views/sign_in_view.dart';
import 'package:docdoc/features/sign_up/presentation/views/sign_up_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding,
    routes: [
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
        path: RouteNames.blankView,
        name: 'blankView',
        builder: (context, state) => const BlankView(),
      ),
    ],
  );
}