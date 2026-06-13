class MessageModel {
  final String id;
  final String connectionId;
  final String senderId;
  final String content;
  final String messageType;
  final DateTime sentAt;
  final DateTime? readAt;
  final bool isDeleted;

  MessageModel({
    required this.id,
    required this.connectionId,
    required this.senderId,
    required this.content,
    this.messageType = 'text',
    DateTime? sentAt,
    this.readAt,
    this.isDeleted = false,
  }) : sentAt = sentAt ?? DateTime.now();

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      connectionId: json['connection_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      content: json['content'] ?? '',
      messageType: json['message_type'] ?? 'text',
      sentAt: json['sent_at'] != null ? DateTime.parse(json['sent_at']) : DateTime.now(),
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      isDeleted: json['is_deleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'connection_id': connectionId,
      'sender_id': senderId,
      'content': content,
      'message_type': messageType,
    };
  }

  bool get isRead => readAt != null;
}
