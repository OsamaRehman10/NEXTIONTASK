import 'package:flutter/material.dart';
import 'package:movie/Routes/app_navigation.dart';
import 'package:movie/Routes/app_navigation_routes.dart';
import 'package:movie/Routes/route_generator.dart';
import 'package:movie/Utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Network App',
        navigatorKey: AppNavigation.navigationKey,
        initialRoute: AppNavRoutes.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        //Theme
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        // //system
        themeMode: ThemeMode.light,
      );
    });
  }
}
