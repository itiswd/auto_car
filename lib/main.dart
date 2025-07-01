import 'package:auto_car/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Car Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 70,
          backgroundColor: Colors.black,
          indicatorColor: Colors.indigo.withOpacity(0.25),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
