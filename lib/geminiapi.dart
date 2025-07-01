import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAPI{
  static const String API_KEY = "AIzaSyAQjhFCtyQcx9qJMCNMHyZatrHXnKPIfXk";
  static const String API_URL = "https://generativeai.googleapis.com/v1alpha3/models/gemini-1.5-flash:generate";
  static const String BASE_URL = "http://10.0.2.2:5000";

  Future<String> callFunction(String param) async {
    final url = Uri.parse('$BASE_URL/call_function');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'param': param}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['result'];
    } else {
      throw Exception('Failed to call Python API: ${response.statusCode}');
    }
  }
}
