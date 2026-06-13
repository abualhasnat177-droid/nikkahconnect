import '../network/api_client.dart';

class SubscriptionService {
  final ApiClient _api = ApiClient();

  Future<List<dynamic>> getPlans() async {
    final response = await _api.get('/subscriptions/plans');
    return response.data;
  }

  Future<Map<String, dynamic>> createSubscription({
    required int planId,
    required String paymentGateway,
    required String transactionId,
    required double amount,
    required String currency,
  }) async {
    final response = await _api.post('/subscriptions', data: {
      'plan_id': planId,
      'payment_gateway': paymentGateway,
      'transaction_id': transactionId,
      'amount': amount,
      'currency': currency,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getCurrentSubscription() async {
    final response = await _api.get('/subscriptions/me');
    return response.data;
  }
}
