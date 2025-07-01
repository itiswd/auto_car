import 'dart:ui';

import 'package:auto_car/core/shared_prefs.dart';
import 'package:flutter/material.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen>
    with TickerProviderStateMixin {
  String? _currentDeviceName;
  String? _currentDeviceAddress;
  String? _lastCommand;
  bool _isConnected = false;

  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final isConnected = await SharedPrefs.isConnected();
    final name = await SharedPrefs.getCurrentDeviceName();
    final address = await SharedPrefs.getCurrentDeviceAddress();
    final lastCmd = await SharedPrefs.getLastCommand();

    setState(() {
      _isConnected = isConnected;
      _currentDeviceName = name;
      _currentDeviceAddress = address;
      _lastCommand = lastCmd;
    });

    _fadeController.forward(from: 0);
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      ),
    );
  }

  Widget _statusItem(String title, String value, IconData icon, Color color) {
    return _glassCard(
      child: ListTile(
        leading: Icon(icon, color: color, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Status View"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _loadStatus,
          child: FadeTransition(
            opacity: _fadeController,
            child: ListView(
              padding: const EdgeInsets.only(top: 100, bottom: 40),
              children: [
                _statusItem(
                  "Connection Status",
                  _isConnected ? "Connected ✅" : "Disconnected ❌",
                  _isConnected ? Icons.check_circle : Icons.cancel,
                  _isConnected ? Colors.green : Colors.red,
                ),
                _statusItem(
                  "Device Name",
                  _currentDeviceName ?? "Not Connected",
                  Icons.devices,
                  Colors.blue,
                ),
                _statusItem(
                  "Device Address",
                  _currentDeviceAddress ?? "-",
                  Icons.qr_code,
                  Colors.grey,
                ),
                _statusItem(
                  "Last Command Sent",
                  _lastCommand ?? "None",
                  Icons.send,
                  Colors.deepPurple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
