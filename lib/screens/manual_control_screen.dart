import 'package:flutter/material.dart';

class ManualControlScreen extends StatelessWidget {
  final TextEditingController speedController = TextEditingController();

  ManualControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Set speed to control the car:"),
          TextField(
            controller: speedController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Speed"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Send speed to car
            },
            child: Text("Drive"),
          ),
        ],
      ),
    );
  }
}
