import 'package:flutter/material.dart';

class ControlOptionsScreen extends StatelessWidget {
  const ControlOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Automatic Mode 1")),
          ElevatedButton(onPressed: () {}, child: Text("Automatic Mode 2")),
        ],
      ),
    );
  }
}
