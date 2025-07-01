import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_car/core/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen>
    with TickerProviderStateMixin {
  BluetoothConnection? _connection;
  double _speed = 50;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _initConnection();
  }

  Future<void> _initConnection() async {
    final address = await SharedPrefs.getCurrentDeviceAddress();
    if (address != null) {
      _connection = await BluetoothConnection.toAddress(address);
      setState(() {});
    }
    _fadeController.forward();
  }

  void _sendCommand(String command) {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(command.codeUnits));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sent: $command")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Not connected")));
    }
  }

  Widget _buildControlButton(
    IconData icon,
    String cmd, {
    Color color = Colors.teal,
  }) {
    return GestureDetector(
      onTap: () => _sendCommand(cmd),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 30)),
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Manual Control"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _glassCard(
                child: Column(
                  children: [
                    const Text(
                      "Control Panel",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Layout gamepad style
                    Column(
                      children: [
                        _buildControlButton(Icons.arrow_upward, "F"),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildControlButton(Icons.arrow_back, "L"),
                            const SizedBox(width: 16),
                            _buildControlButton(
                              Icons.stop_circle_outlined,
                              "S",
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 16),
                            _buildControlButton(Icons.arrow_forward, "R"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildControlButton(Icons.arrow_downward, "B"),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
              _glassCard(
                child: Column(
                  children: [
                    Text(
                      "Speed: ${_speed.toInt()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _speed,
                      onChanged: (val) => setState(() => _speed = val),
                      min: 0,
                      max: 100,
                      activeColor: Colors.teal,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => _sendCommand(_speed.toInt().toString()),
                      icon: const Icon(Icons.speed),
                      label: const Text("Send Speed"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
