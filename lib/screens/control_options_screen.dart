import 'package:flutter/material.dart';

class ControlOptionsScreen extends StatelessWidget {
  const ControlOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // send mode 1
            },
            icon: const Icon(Icons.flash_on),
            label: const Text('Automatic Mode 1'),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // send mode 2
            },
            icon: const Icon(Icons.flash_auto),
            label: const Text('Automatic Mode 2'),
          ),
        ],
      ),
    );
  }
}
