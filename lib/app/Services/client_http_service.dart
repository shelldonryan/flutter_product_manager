import 'dart:convert';
import 'package:http/http.dart';
import '../interfaces/http_client_interface.dart';

class ClientHttpService implements IHttpClient {
  final httpClient = Client();
  String? _token;

  @override
  Future get(String url) async {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    final response = await httpClient.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch data: ${response.body}");
    }
  }
  
  @override
  Future post(String url, Map<String, dynamic> json) async {
    final headers = {'Content-type': 'application/json'};
    final response = await httpClient.post(Uri.parse(url), headers: headers, body: jsonEncode(json));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data: ${response.body}');
    }

  }

  @override
  Future addToken(String token) async {
    _token = token;
  }

}