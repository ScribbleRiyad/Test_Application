abstract class BaseApiServices {

  Future<dynamic> getApi(String url);

  Future<dynamic> getApiWithParams(String url, parameters);
  Future<dynamic> getApiData(String url, payload);
  Future<dynamic> postApi(payload, url);

  Future<dynamic> putApi(payload, url);
}