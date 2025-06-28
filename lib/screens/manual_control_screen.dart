import 'package:flutter/material.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen> {
  double _speed = 0;

  void _sendSpeedToCar() {
    // send _speed to car via WiFi or whatever method used originally
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Set Car Speed',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            '${_speed.toInt()} km/h',
            style: const TextStyle(fontSize: 32, color: Colors.indigo),
          ),
          Slider(
            value: _speed,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_speed.toInt()} km/h',
            onChanged: (value) {
              setState(() => _speed = value);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _sendSpeedToCar,
            icon: const Icon(Icons.send),
            label: const Text('Drive'),
          ),
        ],
      ),
    );
  }
}
