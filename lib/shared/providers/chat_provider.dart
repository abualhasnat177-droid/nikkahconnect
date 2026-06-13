import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/message_service.dart';
import '../models/message_model.dart';

class ChatState {
  final Map<String, List<MessageModel>> messages;
  final bool isLoading;
  final String? error;
  final int dailyMessageCount;

  ChatState({
    this.messages = const {},
    this.isLoading = false,
    this.error,
    this.dailyMessageCount = 0,
  });

  ChatState copyWith({
    Map<String, List<MessageModel>>? messages,
    bool? isLoading,
    String? error,
    int? dailyMessageCount,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      dailyMessageCount: dailyMessageCount ?? this.dailyMessageCount,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final MessageService _service = MessageService();

  ChatNotifier() : super(ChatState());

  Future<void> loadMessages(String connectionId) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _service.getMessages(connectionId);
      final msgs = data.map((e) => MessageModel.fromJson(e)).toList();
      final updatedMessages = Map<String, List<MessageModel>>.from(state.messages);
      updatedMessages[connectionId] = msgs;
      state = state.copyWith(messages: updatedMessages, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to load messages');
    }
  }

  Future<bool> sendMessage(String connectionId, String content) async {
    try {
      final data = await _service.sendMessage(connectionId, content);
      final msg = MessageModel.fromJson(data);
      final updatedMessages = Map<String, List<MessageModel>>.from(state.messages);
      updatedMessages[connectionId] = [...(updatedMessages[connectionId] ?? []), msg];
      state = state.copyWith(
        messages: updatedMessages,
        dailyMessageCount: state.dailyMessageCount + 1,
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to send message');
      return false;
    }
  }

  void addRealtimeMessage(String connectionId, MessageModel message) {
    final updatedMessages = Map<String, List<MessageModel>>.from(state.messages);
    updatedMessages[connectionId] = [...(updatedMessages[connectionId] ?? []), message];
    state = state.copyWith(messages: updatedMessages);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
