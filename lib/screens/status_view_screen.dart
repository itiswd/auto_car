import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  Map<String, dynamic> status = {};

  Future<void> fetchStatus() async {
    final uri = Uri.parse('http://192.168.4.1/status');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          status = json.decode(response.body);
        });
      }
    } catch (e) {
      print('Failed to fetch status: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStatus();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchStatus,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: Text("Connection Status"),
            subtitle: Text(status['connection'] ?? 'Loading...'),
          ),
          ListTile(
            title: Text("Device Name"),
            subtitle: Text(status['device'] ?? 'Loading...'),
          ),
          ListTile(
            title: Text("RSSI"),
            subtitle: Text(status['rssi']?.toString() ?? '...'),
          ),
          ListTile(
            title: Text("Distance"),
            subtitle: Text(status['distance']?.toString() ?? '...'),
          ),
          ListTile(
            title: Text("Last Speed"),
            subtitle: Text(status['lastSpeed']?.toString() ?? '...'),
          ),
        ],
      ),
    );
  }
}
