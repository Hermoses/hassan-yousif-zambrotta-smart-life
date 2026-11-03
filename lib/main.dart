import 'package:flutter/material.dart';
import 'screens/dimmers.dart';
import 'screens/home_screen.dart';
import 'screens/plugs.dart';
import 'utilities/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: mythemedata,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeScreen(),
          '/plugs': (context) => const Plugs(),
          '/dimmers': (context) => const Dimmers(),
        });
  }
}
