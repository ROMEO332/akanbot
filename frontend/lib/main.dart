import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akan Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _sendMessage(String message) async {
    final url = Uri.parse('https://twi-chatbot.onrender.com/chat');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _response = json.decode(response.body)['reply'];
      });
    } else {
      setState(() {
        _response = 'Failed to get response';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akan Chatbot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter your message'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _sendMessage(_controller.text);
                _controller.clear();
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
