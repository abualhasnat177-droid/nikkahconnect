class NotificationModel {
  final String id;
  final String userId;
  final String type;
  final String? title;
  final String? body;
  final Map<String, dynamic> data;
  final bool isRead;
  final String sentVia;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    this.title,
    this.body,
    this.data = const {},
    this.isRead = false,
    this.sentVia = 'push',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? 'system',
      title: json['title'],
      body: json['body'],
      data: json['data'] is Map ? Map<String, dynamic>.from(json['data']) : {},
      isRead: json['is_read'] ?? false,
      sentVia: json['sent_via'] ?? 'push',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
    );
  }
}
