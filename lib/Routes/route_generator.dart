import 'package:flutter/material.dart';
import 'package:movie/Routes/app_navigation_routes.dart';
import 'package:movie/screens/HomeScreen/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppNavRoutes.initialRoute:
        return routeScreen(child: const MovieListWidget());

      // case AppNavRoutes.quizScreen:
      //   return routeScreen(child: const QuizScreen());

      // case AppNavRoutes.userScreen:
      //   UserProfileModel kuchbhi = args as UserProfileModel;
      //   return routeScreen(
      //       child: UserScreen(
      //     myProfile: kuchbhi,
      //   ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Text('Error Page');
    });
  }

  static Route<dynamic> routeScreen({
    Widget? child,
  }) {
    return MaterialPageRoute(
      // builder: (context) => child!,
      builder: (context) => SafeArea(
        child: child!,
      ),
    );
  }
}
