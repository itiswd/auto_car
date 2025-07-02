import 'package:auto_car/services/bluetooth_service.dart';
import 'package:flutter/material.dart';

import '../widgets/control_button.dart';
import '../widgets/glass_card.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen>
    with TickerProviderStateMixin {
  double _speed = 50;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await BluetoothService().connect();
    _fadeController.forward();
  }

  void _sendCommand(String command) async {
    try {
      await BluetoothService().send(command);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✅ Sent: $command")));
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("❌ Not connected")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              GlassCard(
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
                    Column(
                      children: [
                        ControlButton(
                          icon: Icons.arrow_upward,
                          label: "Forward",
                          onTap: () => _sendCommand("F"),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ControlButton(
                              icon: Icons.arrow_back,
                              label: "Left",
                              onTap: () => _sendCommand("L"),
                            ),
                            const SizedBox(width: 24),
                            ControlButton(
                              icon: Icons.stop_circle_outlined,
                              label: "Stop",
                              color: Colors.redAccent,
                              onTap: () => _sendCommand("S"),
                            ),
                            const SizedBox(width: 24),
                            ControlButton(
                              icon: Icons.arrow_forward,
                              label: "Right",
                              onTap: () => _sendCommand("R"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ControlButton(
                          icon: Icons.arrow_downward,
                          label: "Backward",
                          onTap: () => _sendCommand("B"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        ControlButton(
                          icon: Icons.shield,
                          label: "Obstacle",
                          onTap: () => _sendCommand("O"),
                        ),
                        ControlButton(
                          icon: Icons.remove_red_eye,
                          label: "Blind Spot",
                          onTap: () => _sendCommand("D"),
                        ),
                        ControlButton(
                          icon: Icons.local_parking,
                          label: "Auto Park",
                          onTap: () => _sendCommand("P"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GlassCard(
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
