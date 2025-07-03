import 'package:auto_car/screens/home_with_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/bluetooth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BluetoothProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeWithNav(),
    );
  }
}
