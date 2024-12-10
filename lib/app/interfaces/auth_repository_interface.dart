abstract class IAuthRepository {
  Future login(String username, String password);
  Future register(String username, String password,String confirmPassword, String type);
  Future logout();
}