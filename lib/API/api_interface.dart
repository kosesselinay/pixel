import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();
  Future<bool> resetTheContext(String contentMessage) async {
    var url = Uri.parse('http://localhost:3000/reset');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"reset": true});

    var response = await http.get(url, headers: headers);
    var responseBody = response.body;

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> sendPostRequest(String contentMessage) async {
    var url = Uri.parse('http://192.168.110.163:3000/speak');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "userMessage": {"role": "user", "content": contentMessage}
    });

    var response = await http.post(url, headers: headers, body: body);
    var responseBody = response.body;

    if (response.statusCode == 200) {
      var decodedResponse = utf8.decode(responseBody.runes.toList());

      var jsonResponse = json.decode(decodedResponse);
      var message = jsonResponse['message'];
      String content = message['content'];
      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return '';
  }
}
