import 'package:flutter/material.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen> {
  double _speed = 0;

  void _sendSpeedToCar() {
    // Send _speed to car
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Speed: ${_speed.toStringAsFixed(0)}'),
          Slider(
            value: _speed,
            min: 0,
            max: 100,
            divisions: 20,
            label: _speed.toStringAsFixed(0),
            onChanged: (val) => setState(() => _speed = val),
          ),
          ElevatedButton(
            onPressed: _sendSpeedToCar,
            child: const Text('Drive'),
          ),
        ],
      ),
    );
  }
}
