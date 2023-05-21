import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/my_colors_provider.dart';
import 'screens/home_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => MyColors(),
              child: const HomeScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => MyColors(),
              child: const HomeScreen(),
            );
          },
        );
    }
  }
}