import 'package:flutter/material.dart';

import 'control_options_screen.dart';
import 'manual_control_screen.dart';
import 'settings_screen.dart';
import 'status_view_screen.dart';
import 'wifi_scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WifiScannerScreen(),
    const ControlOptionsScreen(),
    const ManualControlScreen(),
    const StatusViewScreen(),
    const SettingsScreen(),
  ];

  final List<String> _titles = [
    'Wi-Fi Scanner',
    'Control Options',
    'Manual Control',
    'Status View',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wifi), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: 'Control'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Manual',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Status'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  // connect to car wifi
                },
                child: const Icon(Icons.search),
              )
              : null,
    );
  }
}
