import 'package:flutter/material.dart';

import '../core/shared_prefs.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen> {
  double _speed = 0;
  bool _isSending = false;

  Future<void> _sendSpeedToCar() async {
    setState(() => _isSending = true);

    final command = _speed.toInt().toString();
    print("Sending: $command");

    await SharedPrefs.saveLastCommand(command);

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isSending = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Command Sent: $command")));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Set Car Speed',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '${_speed.toInt()} km/h',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(color: Colors.indigo),
            ),
          ),
          const SizedBox(height: 16),
          Slider(
            value: _speed,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_speed.toInt()} km/h',
            onChanged: (value) => setState(() => _speed = value),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.indigo,
            ),
            onPressed: _isSending ? null : _sendSpeedToCar,
            icon:
                _isSending
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Icon(Icons.send),
            label: Text(_isSending ? "Sending..." : "Send Command"),
          ),
        ],
      ),
    );
  }
}
