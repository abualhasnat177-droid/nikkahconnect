import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/connection_service.dart';
import '../models/connection_model.dart';

class ConnectionState {
  final List<ConnectionModel> received;
  final List<ConnectionModel> sent;
  final List<ConnectionModel> matches;
  final bool isLoading;
  final String? error;

  ConnectionState({
    this.received = const [],
    this.sent = const [],
    this.matches = const [],
    this.isLoading = false,
    this.error,
  });

  ConnectionState copyWith({
    List<ConnectionModel>? received,
    List<ConnectionModel>? sent,
    List<ConnectionModel>? matches,
    bool? isLoading,
    String? error,
  }) {
    return ConnectionState(
      received: received ?? this.received,
      sent: sent ?? this.sent,
      matches: matches ?? this.matches,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final ConnectionService _service = ConnectionService();

  ConnectionNotifier() : super(ConnectionState());

  Future<void> loadConnections() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await _service.getConnections();
      state = state.copyWith(
        received: (data['received'] as List?)?.map((e) => ConnectionModel.fromJson(e)).toList() ?? [],
        sent: (data['sent'] as List?)?.map((e) => ConnectionModel.fromJson(e)).toList() ?? [],
        matches: (data['matches'] as List?)?.map((e) => ConnectionModel.fromJson(e)).toList() ?? [],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load connections');
    }
  }

  Future<void> sendEoi(String receiverId) async {
    try {
      await _service.sendEoi(receiverId);
      await loadConnections();
    } catch (e) {
      state = state.copyWith(error: 'Failed to send interest');
    }
  }

  Future<void> respondToEoi(String connectionId, String status) async {
    try {
      await _service.respondToEoi(connectionId, status);
      await loadConnections();
    } catch (e) {
      state = state.copyWith(error: 'Failed to respond');
    }
  }
}

final connectionProvider = StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
  return ConnectionNotifier();
});
