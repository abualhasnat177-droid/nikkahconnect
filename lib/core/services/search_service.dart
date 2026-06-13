import '../network/api_client.dart';

class SearchService {
  final ApiClient _api = ApiClient();

  Future<Map<String, dynamic>> search({
    String? query,
    String? gender,
    int? ageMin,
    int? ageMax,
    String? countryCode,
    String? city,
    String? sectIds,
    String? casteIds,
    int page = 1,
    int limit = 20,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (query != null) params['q'] = query;
    if (gender != null) params['gender'] = gender;
    if (ageMin != null) params['age_min'] = ageMin;
    if (ageMax != null) params['age_max'] = ageMax;
    if (countryCode != null) params['country_code'] = countryCode;
    if (city != null) params['city'] = city;
    if (sectIds != null) params['sect_ids'] = sectIds;
    if (casteIds != null) params['caste_ids'] = casteIds;

    final response = await _api.get('/search', queryParameters: params);
    return response.data;
  }

  Future<List<dynamic>> getFeed() async {
    final response = await _api.get('/search/feed');
    return response.data['results'] ?? [];
  }
}
