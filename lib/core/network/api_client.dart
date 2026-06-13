import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  late final Dio dio;

  static Future<void> init() async {
    _instance.dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.nikahconnect.com/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _instance.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await SecureStorage.getRefreshToken();
            if (refreshToken != null) {
              try {
                final response = await _instance.dio.post(
                  '/auth/refresh',
                  data: {'refresh_token': refreshToken},
                );
                final newToken = response.data['access_token'];
                await SecureStorage.setAccessToken(newToken);
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                final retryResponse = await _instance.dio.fetch(error.requestOptions);
                handler.resolve(retryResponse);
                return;
              } catch (_) {}
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      dio.get(path, queryParameters: queryParameters);

  Future<Response> post(String path, {dynamic data}) =>
      dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      dio.put(path, data: data);

  Future<Response> patch(String path, {dynamic data}) =>
      dio.patch(path, data: data);

  Future<Response> delete(String path) =>
      dio.delete(path);
}
