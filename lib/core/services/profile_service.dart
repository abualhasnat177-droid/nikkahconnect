import '../network/api_client.dart';
import '../../shared/models/profile_model.dart';

class ProfileService {
  final ApiClient _api = ApiClient();

  Future<ProfileModel> getMyProfile() async {
    final response = await _api.get('/profiles/me');
    return ProfileModel.fromJson(response.data);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _api.put('/profiles/me', data: data);
  }

  Future<ProfileModel> getProfile(String id) async {
    final response = await _api.get('/profiles/$id');
    return ProfileModel.fromJson(response.data);
  }

  Future<void> uploadPhoto(String storagePath) async {
    await _api.post('/profiles/me/photos', data: {
      'storage_path': storagePath,
    });
  }

  Future<void> deletePhoto(String id) async {
    await _api.delete('/profiles/me/photos/$id');
  }

  Future<List<dynamic>> getSects() async {
    final response = await _api.get('/profiles/reference/sects');
    return response.data;
  }

  Future<List<dynamic>> getCastes() async {
    final response = await _api.get('/profiles/reference/castes');
    return response.data;
  }
}
