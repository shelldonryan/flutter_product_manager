import 'package:mobx/mobx.dart';
import '../repositories/user_repository.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final UserRepository userRepository;

  AuthStoreBase(this.userRepository);

  @observable
  String? token;

  @observable
  bool isLoading = false;

  @action
  Future<void> login(String username, String password) async {
    isLoading = true;
    try {
      token = await userRepository.login(username, password);
    } catch (e) {
      throw Exception('Login failed: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> register(String username, String password, String confirmPassword, String type) async {
    isLoading = true;
    try {
      await userRepository.register(username, password, confirmPassword, type);
    } catch (e) {
      throw Exception('Registration failed: $e');
    } finally {
      isLoading = false;
    }

  }

  @action
  Future<void> logout() async{
    token = null;
    await userRepository.logout();
  }
}