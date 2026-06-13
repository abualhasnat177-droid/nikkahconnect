import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/profile_service.dart';
import '../models/profile_model.dart';

class ProfileState {
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;
  final List<dynamic> sects;
  final List<dynamic> castes;

  ProfileState({
    this.profile,
    this.isLoading = false,
    this.error,
    this.sects = const [],
    this.castes = const [],
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? error,
    List<dynamic>? sects,
    List<dynamic>? castes,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sects: sects ?? this.sects,
      castes: castes ?? this.castes,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileService _service = ProfileService();

  ProfileNotifier() : super(ProfileState());

  Future<void> loadMyProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profile = await _service.getMyProfile();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load profile');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.updateProfile(data);
      await loadMyProfile();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to update profile');
    }
  }

  Future<void> loadReferenceData() async {
    try {
      final sects = await _service.getSects();
      final castes = await _service.getCastes();
      state = state.copyWith(sects: sects, castes: castes);
    } catch (_) {}
  }

  void clearError() => state = state.copyWith(error: null);
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
