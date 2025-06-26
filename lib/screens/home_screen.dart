import 'package:auto_car/screens/control_options_screen.dart';
import 'package:auto_car/screens/manual_control_screen.dart';
import 'package:auto_car/screens/settings_screen.dart';
import 'package:auto_car/screens/status_view_screen.dart';
import 'package:auto_car/screens/wifi_scanner_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ControlOptionsScreen(),
    ManualControlScreen(),
    StatusViewScreen(),
    SettingsScreen(),
  ];

  void _onFabPressed() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => WifiScannerScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Control',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.drive_eta), label: 'Manual'),
          BottomNavigationBarItem(icon: Icon(Icons.wifi), label: 'Status'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: Icon(Icons.wifi_tethering),
      ),
    );
  }
}
