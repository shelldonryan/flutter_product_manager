abstract class IHttpClient {
  Future addToken(String token);
  Future get(String url);
  Future post(String url, Map<String, dynamic> json);
}