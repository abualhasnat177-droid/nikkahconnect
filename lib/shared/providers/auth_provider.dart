import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/secure_storage.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _api = ApiClient();

  AuthNotifier() : super(AuthState());

  Future<void> checkAuth() async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      state = state.copyWith(isAuthenticated: true);
    }
  }

  Future<void> login(String identifier, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/auth/login', data: {
        'identifier': identifier,
        'password': password,
      });
      final data = response.data;
      await SecureStorage.setAccessToken(data['access_token']);
      await SecureStorage.setRefreshToken(data['refresh_token']);
      await SecureStorage.setUserId(data['user']['id']);
      state = state.copyWith(
        user: UserModel.fromJson(data['user']),
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Login failed. Please check your credentials.');
    }
  }

  Future<void> register({
    required String phone,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/auth/register', data: {
        'phone': phone,
        'email': email,
        'password': password,
      });
      final data = response.data;
      await SecureStorage.setAccessToken(data['access_token']);
      await SecureStorage.setRefreshToken(data['refresh_token']);
      await SecureStorage.setUserId(data['user']['id']);
      state = state.copyWith(
        user: UserModel.fromJson(data['user']),
        isAuthenticated: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Registration failed. Please try again.');
    }
  }

  Future<void> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _api.post('/auth/otp/send', data: {'phone': phone});
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to send OTP.');
    }
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/auth/otp/verify', data: {
        'phone': phone,
        'otp': otp,
      });
      state = state.copyWith(isLoading: false);
      return response.statusCode == 200;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Invalid OTP.');
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.clearAll();
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
