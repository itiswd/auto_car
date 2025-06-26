import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlOptionsScreen extends StatelessWidget {
  const ControlOptionsScreen({super.key});

  Future<void> sendAutoCommand(String mode) async {
    final uri = Uri.parse('http://192.168.4.1/auto?mode=$mode');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print('Mode $mode activated');
      }
    } catch (e) {
      print('Failed to send mode: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose Automatic Control Mode",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(Icons.smart_toy),
            onPressed: () => sendAutoCommand("mode1"),
            label: Text("Automatic Mode 1"),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(Icons.smart_toy_outlined),
            onPressed: () => sendAutoCommand("mode2"),
            label: Text("Automatic Mode 2"),
          ),
        ],
      ),
    );
  }
}
