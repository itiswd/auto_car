import 'package:flutter/material.dart';

class ControlOptionsScreen extends StatelessWidget {
  const ControlOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ElevatedButton(
          onPressed: () {
            // Send data to car: Mode 1
          },
          child: const Text('Automatic Mode 1'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Send data to car: Mode 2
          },
          child: const Text('Automatic Mode 2'),
        ),
      ],
    );
  }
}
