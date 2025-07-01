import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // 👇 هنا تبعت الأمر للSTM، مثلاً عبر البلوتوث
    final command = _speed.toInt().toString();
    print("Sending: $command");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_command', command);

    await Future.delayed(const Duration(milliseconds: 500)); // simulate send
    setState(() => _isSending = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Command Sent: $command")));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Set Car Speed',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // سرعة السيارة
          Center(
            child: Text(
              '${_speed.toInt()} km/h',
              style: theme.textTheme.displaySmall?.copyWith(
                color: Colors.indigo,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // السلايدر
          Slider(
            value: _speed,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_speed.toInt()} km/h',
            onChanged: (value) => setState(() => _speed = value),
          ),

          const SizedBox(height: 40),

          // زر الإرسال
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
