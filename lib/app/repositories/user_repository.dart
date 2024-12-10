import '../interfaces/auth_repository_interface.dart';
import '../interfaces/http_client_interface.dart';

class UserRepository implements IAuthRepository{

  final IHttpClient http;

  UserRepository(this.http);

  @override
  Future<String> login(String username, String password) async {
    final Map<String, dynamic> response = await http.post("http://10.0.2.2:5001/api/users/verifyLogin", {
      'username': username,
      'password': password
    });

    if (response.containsKey('token')) {
      final token = response['token'];
      http.addToken(token);
      return token;
    } else {
      throw Exception('Failed to login: $response');
    }
   }

  @override
  Future<void> register(String username, String password,String confirmPassword, String type) async {
    final response = await http.post("http://10.0.2.2:5001/api/users/register", {
      'username': username,
      'password': password,
      'confirm-password': confirmPassword,
      'type': type
    });

    if (!response.containsKey('success')) {
      throw Exception('Failed to register: $response');
    }
  }

  @override
  Future logout() async {

  }
}

