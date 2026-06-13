import '../network/api_client.dart';

class ConnectionService {
  final ApiClient _api = ApiClient();

  Future<Map<String, dynamic>> sendEoi(String receiverId) async {
    final response = await _api.post('/connections', data: {
      'receiver_id': receiverId,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getConnections({String? status}) async {
    final params = <String, dynamic>{};
    if (status != null) params['status'] = status;
    final response = await _api.get('/connections', queryParameters: params);
    return response.data;
  }

  Future<void> respondToEoi(String connectionId, String status) async {
    await _api.patch('/connections/$connectionId', data: {
      'status': status,
    });
  }

  Future<void> withdrawEoi(String connectionId) async {
    await _api.delete('/connections/$connectionId');
  }
}
