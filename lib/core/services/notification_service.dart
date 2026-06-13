import '../network/api_client.dart';

class NotificationService {
  final ApiClient _api = ApiClient();

  Future<Map<String, dynamic>> getNotifications({
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _api.get('/notifications', queryParameters: {
      'page': page,
      'limit': limit,
    });
    return response.data;
  }

  Future<void> markAsRead(String id) async {
    await _api.patch('/notifications/$id/read');
  }

  Future<void> markAllAsRead() async {
    await _api.patch('/notifications/read-all');
  }
}
