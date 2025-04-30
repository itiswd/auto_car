import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(RemoteControlApp());
}

class RemoteControlApp extends StatelessWidget {
  const RemoteControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تحكم في العربة',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RemoteControlPage(),
    );
  }
}

class RemoteControlPage extends StatefulWidget {
  const RemoteControlPage({super.key});

  @override
  _RemoteControlPageState createState() => _RemoteControlPageState();
}

class _RemoteControlPageState extends State<RemoteControlPage> {
  // عنوان IP الخاص بجهاز ESP
  String espIp = '192.168.1.100'; // استبدل بعنوان IP الخاص بجهازك
  bool isForwardPressed = false;
  bool isBackwardPressed = false;
  bool isLeftPressed = false;
  bool isRightPressed = false;

  // دالة لإرسال الأوامر إلى ESP
  Future<void> sendCommand(String command) async {
    try {
      final response = await http.get(
        Uri.parse('http://$espIp/$command'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('تم إرسال الأمر: $command');
      } else {
        print('فشل إرسال الأمر: ${response.statusCode}');
      }
    } catch (e) {
      print('خطأ في الاتصال: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('تحكم في العربة')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // زر التحرك للأمام
            GestureDetector(
              onTapDown: (_) {
                setState(() => isForwardPressed = true);
                sendCommand('forward');
              },
              onTapUp: (_) {
                setState(() => isForwardPressed = false);
                sendCommand('stop');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isForwardPressed ? Colors.green : Colors.green[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.arrow_upward, size: 50),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر التحرك لليسار
                GestureDetector(
                  onTapDown: (_) {
                    setState(() => isLeftPressed = true);
                    sendCommand('left');
                  },
                  onTapUp: (_) {
                    setState(() => isLeftPressed = false);
                    sendCommand('stop');
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isLeftPressed ? Colors.blue : Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.arrow_back, size: 50),
                  ),
                ),
                SizedBox(width: 20),
                // زر الإيقاف (اختياري)
                GestureDetector(
                  onTap: () {
                    sendCommand('stop');
                  },

                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isBackwardPressed ? Colors.red : Colors.red[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.stop, size: 50),
                  ),
                ),
                SizedBox(width: 20),
                // زر التحرك لليمين
                GestureDetector(
                  onTapDown: (_) {
                    setState(() => isRightPressed = true);
                    sendCommand('right');
                  },
                  onTapUp: (_) {
                    setState(() => isRightPressed = false);
                    sendCommand('stop');
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isRightPressed ? Colors.blue : Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.arrow_forward, size: 50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // زر التحرك للخلف
            GestureDetector(
              onTapDown: (_) {
                setState(() => isBackwardPressed = true);
                sendCommand('backward');
              },
              onTapUp: (_) {
                setState(() => isBackwardPressed = false);
                sendCommand('stop');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isBackwardPressed ? Colors.green : Colors.green[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.arrow_downward, size: 50),
              ),
            ),

            SizedBox(height: 20),

            // حقل لتعديل عنوان IP
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       labelText: 'عنوان ESP IP',
            //       border: OutlineInputBorder(),
            //     ),
            //     onChanged: (value) {
            //       setState(() {
            //         espIp = value;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
