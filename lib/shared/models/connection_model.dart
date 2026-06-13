class ConnectionModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String status;
  final DateTime sentAt;
  final DateTime? respondedAt;
  final DateTime expiresAt;
  final ProfileSummary? sender;
  final ProfileSummary? receiver;

  ConnectionModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.status = 'pending',
    DateTime? sentAt,
    this.respondedAt,
    DateTime? expiresAt,
    this.sender,
    this.receiver,
  })  : sentAt = sentAt ?? DateTime.now(),
        expiresAt = expiresAt ?? DateTime.now().add(const Duration(days: 30));

  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      id: json['id'] ?? '',
      senderId: json['sender_id'] ?? '',
      receiverId: json['receiver_id'] ?? '',
      status: json['status'] ?? 'pending',
      sentAt: json['sent_at'] != null ? DateTime.parse(json['sent_at']) : DateTime.now(),
      respondedAt: json['responded_at'] != null ? DateTime.parse(json['responded_at']) : null,
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : DateTime.now().add(const Duration(days: 30)),
      sender: json['sender'] != null ? ProfileSummary.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? ProfileSummary.fromJson(json['receiver']) : null,
    );
  }
}

class ProfileSummary {
  final String id;
  final String displayName;
  final int age;
  final String? city;
  final String? countryCode;
  final String? occupation;
  final String? sectName;
  final String? casteName;
  final String? primaryPhoto;

  ProfileSummary({
    required this.id,
    required this.displayName,
    required this.age,
    this.city,
    this.countryCode,
    this.occupation,
    this.sectName,
    this.casteName,
    this.primaryPhoto,
  });

  factory ProfileSummary.fromJson(Map<String, dynamic> json) {
    return ProfileSummary(
      id: json['id'] ?? '',
      displayName: json['display_name'] ?? '',
      age: json['age'] ?? 0,
      city: json['city'],
      countryCode: json['country_code'],
      occupation: json['occupation'],
      sectName: json['sect_name'],
      casteName: json['caste_name'],
      primaryPhoto: json['primary_photo'],
    );
  }
}
