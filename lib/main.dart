import 'package:auto_car/screens/bluetooth_scanner_screen.dart';
import 'package:auto_car/screens/manual_control_screen.dart';
import 'package:auto_car/screens/status_view_screen.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeWithNav(),
    );
  }
}

class HomeWithNav extends StatefulWidget {
  const HomeWithNav({super.key});

  @override
  State<HomeWithNav> createState() => _HomeWithNavState();
}

class _HomeWithNavState extends State<HomeWithNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    BluetoothScreen(),
    ManualControlScreen(),
    StatusViewScreen(),
  ];

  final List<String> _titles = const ["Bluetooth", "Manual Control", "Status"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bluetooth),
            label: "Bluetooth",
          ),
          NavigationDestination(icon: Icon(Icons.gamepad), label: "Control"),
          NavigationDestination(icon: Icon(Icons.info), label: "Status"),
        ],
      ),
    );
  }
}
