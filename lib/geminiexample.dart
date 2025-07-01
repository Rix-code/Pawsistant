import 'package:flutter/material.dart';
import 'geminiapi.dart';

class GeminiEx extends StatefulWidget{
  final String title;
  const GeminiEx({super.key, required this.title});

  @override
  State<GeminiEx> createState() => _GeminiExState();
}

class _GeminiExState extends State<GeminiEx> {
  final GeminiAPI pythonApi = GeminiAPI();
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();

  // Function to call the Python API and update the TextField
  Future<void> _fetchAndDisplayResult() async {
    final userInput = _inputController.text;
    if (userInput.isEmpty) {
      _textFieldController.text = "Please enter a prompt!";
      return;
    }
    _textFieldController.text = "Loading...";

    try {
      final result = await pythonApi.callFunction(userInput);
      setState(() {
        _textFieldController.text = result;
      });
    } catch (e) {
      setState(() {
        _textFieldController.text = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Python API Integration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter Prompt',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchAndDisplayResult,
              child: const Text('Send to Python API'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textFieldController,
              readOnly: true, // Make this field read-only
              decoration: const InputDecoration(
                labelText: 'API Response',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}