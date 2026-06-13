import '../network/api_client.dart';
import '../../shared/models/user_model.dart';

class AuthService {
  final ApiClient _api = ApiClient();

  Future<Map<String, dynamic>> register({
    required String phone,
    required String email,
    required String password,
  }) async {
    final response = await _api.post('/auth/register', data: {
      'phone': phone,
      'email': email,
      'password': password,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final response = await _api.post('/auth/login', data: {
      'identifier': identifier,
      'password': password,
    });
    return response.data;
  }

  Future<void> sendOtp(String phone) async {
    await _api.post('/auth/otp/send', data: {'phone': phone});
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    final response = await _api.post('/auth/otp/verify', data: {
      'phone': phone,
      'otp': otp,
    });
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await _api.post('/auth/refresh', data: {
      'refresh_token': refreshToken,
    });
    return response.data;
  }

  Future<void> logout() async {
    await _api.delete('/auth/logout');
  }
}
