import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/search_service.dart';
import '../models/profile_model.dart';

class SearchState {
  final List<ProfileModel> results;
  final List<ProfileModel> feed;
  final bool isLoading;
  final String? error;
  final int total;
  final int page;
  final Map<String, dynamic> filters;

  SearchState({
    this.results = const [],
    this.feed = const [],
    this.isLoading = false,
    this.error,
    this.total = 0,
    this.page = 1,
    this.filters = const {},
  });

  SearchState copyWith({
    List<ProfileModel>? results,
    List<ProfileModel>? feed,
    bool? isLoading,
    String? error,
    int? total,
    int? page,
    Map<String, dynamic>? filters,
  }) {
    return SearchState(
      results: results ?? this.results,
      feed: feed ?? this.feed,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      total: total ?? this.total,
      page: page ?? this.page,
      filters: filters ?? this.filters,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  final SearchService _service = SearchService();

  SearchNotifier() : super(SearchState());

  Future<void> loadFeed() async {
    state = state.copyWith(isLoading: true);
    try {
      final feed = await _service.getFeed();
      state = state.copyWith(
        feed: feed.map((e) => ProfileModel.fromJson(e)).toList(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load feed');
    }
  }

  Future<void> search(Map<String, dynamic> filters, {int page = 1}) async {
    state = state.copyWith(isLoading: true, filters: filters, page: page);
    try {
      final data = await _service.search(
        query: filters['q'],
        gender: filters['gender'],
        ageMin: filters['age_min'],
        ageMax: filters['age_max'],
        city: filters['city'],
        sectIds: filters['sect_ids'],
        casteIds: filters['caste_ids'],
        page: page,
      );
      state = state.copyWith(
        results: (data['results'] as List?)?.map((e) => ProfileModel.fromJson(e)).toList() ?? [],
        total: data['total'] ?? 0,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Search failed');
    }
  }

  void clearResults() {
    state = state.copyWith(results: [], total: 0, page: 1, filters: {});
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
