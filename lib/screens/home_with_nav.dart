import 'package:auto_car/screens/bluetooth_scanner_screen.dart';
import 'package:auto_car/screens/manual_control_screen.dart';
import 'package:auto_car/screens/status_view_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected:
              (index) => setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.bluetooth),
              label: "Bluetooth",
            ),
            NavigationDestination(icon: Icon(Icons.gamepad), label: "Control"),
            NavigationDestination(icon: Icon(Icons.info), label: "Status"),
          ],
        ),
      ),
    );
  }
}
