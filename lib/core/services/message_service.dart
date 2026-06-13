import '../network/api_client.dart';

class MessageService {
  final ApiClient _api = ApiClient();

  Future<List<dynamic>> getMessages(String connectionId) async {
    final response = await _api.get('/messages/$connectionId');
    return response.data;
  }

  Future<Map<String, dynamic>> sendMessage(
    String connectionId,
    String content, {
    String messageType = 'text',
  }) async {
    final response = await _api.post('/messages/$connectionId', data: {
      'content': content,
      'message_type': messageType,
    });
    return response.data;
  }

  Future<void> markAsRead(String connectionId) async {
    await _api.patch('/messages/$connectionId/read');
  }
}
