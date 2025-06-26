import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManualControlScreen extends StatelessWidget {
  final TextEditingController speedController = TextEditingController();

  ManualControlScreen({super.key});

  Future<void> sendSpeed() async {
    final speed = speedController.text;
    final uri = Uri.parse('http://192.168.4.1/speed?value=$speed');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print('Speed sent: $speed');
      }
    } catch (e) {
      print('Failed to send speed: $e');
    }
  }

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
          ElevatedButton(onPressed: sendSpeed, child: Text("Drive")),
        ],
      ),
    );
  }
}
