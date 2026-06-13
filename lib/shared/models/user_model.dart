class UserModel {
  final String id;
  final String? phone;
  final String? email;
  final String role;
  final String accountType;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  final bool isPremium;
  final DateTime? premiumExpiresAt;
  final String status;
  final DateTime? lastActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    this.phone,
    this.email,
    this.role = 'user',
    this.accountType = 'individual',
    this.isPhoneVerified = false,
    this.isEmailVerified = false,
    this.isPremium = false,
    this.premiumExpiresAt,
    this.status = 'active',
    this.lastActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phone'],
      email: json['email'],
      role: json['role'] ?? 'user',
      accountType: json['account_type'] ?? 'individual',
      isPhoneVerified: json['is_phone_verified'] ?? false,
      isEmailVerified: json['is_email_verified'] ?? false,
      isPremium: json['is_premium'] ?? false,
      premiumExpiresAt: json['premium_expires_at'] != null
          ? DateTime.parse(json['premium_expires_at'])
          : null,
      status: json['status'] ?? 'active',
      lastActive: json['last_active'] != null
          ? DateTime.parse(json['last_active'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'role': role,
      'account_type': accountType,
      'is_phone_verified': isPhoneVerified,
      'is_email_verified': isEmailVerified,
      'is_premium': isPremium,
      'premium_expires_at': premiumExpiresAt?.toIso8601String(),
      'status': status,
      'last_active': lastActive?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
