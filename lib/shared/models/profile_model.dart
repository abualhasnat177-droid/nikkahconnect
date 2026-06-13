class ProfileModel {
  final String id;
  final String userId;
  final String displayName;
  final String? fullName;
  final String gender;
  final DateTime dateOfBirth;
  final String countryCode;
  final String? province;
  final String? city;
  final int? heightCm;
  final String? complexion;
  final String? bodyType;
  final String maritalStatus;
  final int childrenCount;
  final String? educationLevel;
  final String? educationField;
  final String? occupation;
  final String? aboutMe;
  final String? partnerRequirements;
  final int profileCompletePct;
  final String visibility;
  final bool isIdVerified;
  final ReligiousProfile? religious;
  final CulturalProfile? cultural;
  final List<ProfilePhoto> photos;
  final PartnerPreferences? preferences;
  final DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.displayName,
    this.fullName,
    required this.gender,
    required this.dateOfBirth,
    required this.countryCode,
    this.province,
    this.city,
    this.heightCm,
    this.complexion,
    this.bodyType,
    this.maritalStatus = 'never_married',
    this.childrenCount = 0,
    this.educationLevel,
    this.educationField,
    this.occupation,
    this.aboutMe,
    this.partnerRequirements,
    this.profileCompletePct = 0,
    this.visibility = 'public',
    this.isIdVerified = false,
    this.religious,
    this.cultural,
    this.photos = const [],
    this.preferences,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      displayName: json['display_name'] ?? '',
      fullName: json['full_name'],
      gender: json['gender'] ?? 'male',
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      countryCode: json['country_code'] ?? 'PK',
      province: json['province'],
      city: json['city'],
      heightCm: json['height_cm'],
      complexion: json['complexion'],
      bodyType: json['body_type'],
      maritalStatus: json['marital_status'] ?? 'never_married',
      childrenCount: json['children_count'] ?? 0,
      educationLevel: json['education_level'],
      educationField: json['education_field'],
      occupation: json['occupation'],
      aboutMe: json['about_me'],
      partnerRequirements: json['partner_requirements'],
      profileCompletePct: json['profile_complete_pct'] ?? 0,
      visibility: json['visibility'] ?? 'public',
      isIdVerified: json['is_id_verified'] ?? false,
      religious: json['religious'] != null
          ? ReligiousProfile.fromJson(json['religious'])
          : null,
      cultural: json['cultural'] != null
          ? CulturalProfile.fromJson(json['cultural'])
          : null,
      photos: json['photos'] != null
          ? (json['photos'] as List).map((e) => ProfilePhoto.fromJson(e)).toList()
          : [],
      preferences: json['preferences'] != null
          ? PartnerPreferences.fromJson(json['preferences'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'full_name': fullName,
      'gender': gender,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'country_code': countryCode,
      'province': province,
      'city': city,
      'height_cm': heightCm,
      'complexion': complexion,
      'body_type': bodyType,
      'marital_status': maritalStatus,
      'children_count': childrenCount,
      'education_level': educationLevel,
      'education_field': educationField,
      'occupation': occupation,
      'about_me': aboutMe,
      'partner_requirements': partnerRequirements,
      'visibility': visibility,
    };
  }

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}

class ReligiousProfile {
  final int? sectId;
  final String? prayerFrequency;
  final String? quranReading;
  final String? religiosityLevel;
  final String? hijabStatus;
  final String? beardStatus;
  final bool isHafiz;

  ReligiousProfile({
    this.sectId,
    this.prayerFrequency,
    this.quranReading,
    this.religiosityLevel,
    this.hijabStatus,
    this.beardStatus,
    this.isHafiz = false,
  });

  factory ReligiousProfile.fromJson(Map<String, dynamic> json) {
    return ReligiousProfile(
      sectId: json['sect_id'],
      prayerFrequency: json['prayer_frequency'],
      quranReading: json['quran_reading'],
      religiosityLevel: json['religiosity_level'],
      hijabStatus: json['hijab_status'],
      beardStatus: json['beard_status'],
      isHafiz: json['is_hafiz'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sect_id': sectId,
      'prayer_frequency': prayerFrequency,
      'quran_reading': quranReading,
      'religiosity_level': religiosityLevel,
      'hijab_status': hijabStatus,
      'beard_status': beardStatus,
      'is_hafiz': isHafiz,
    };
  }
}

class CulturalProfile {
  final int? casteId;
  final String? motherTongue;
  final String? nationality;
  final String? secondNationality;
  final String? familyType;
  final String? preferredCountry;

  CulturalProfile({
    this.casteId,
    this.motherTongue,
    this.nationality,
    this.secondNationality,
    this.familyType,
    this.preferredCountry,
  });

  factory CulturalProfile.fromJson(Map<String, dynamic> json) {
    return CulturalProfile(
      casteId: json['caste_id'],
      motherTongue: json['mother_tongue'],
      nationality: json['nationality'],
      secondNationality: json['second_nationality'],
      familyType: json['family_type'],
      preferredCountry: json['preferred_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caste_id': casteId,
      'mother_tongue': motherTongue,
      'nationality': nationality,
      'second_nationality': secondNationality,
      'family_type': familyType,
      'preferred_country': preferredCountry,
    };
  }
}

class ProfilePhoto {
  final String id;
  final String profileId;
  final String storagePath;
  final String? thumbnailPath;
  final int orderIndex;
  final bool isPrimary;
  final String moderationStatus;
  final DateTime uploadedAt;

  ProfilePhoto({
    required this.id,
    required this.profileId,
    required this.storagePath,
    this.thumbnailPath,
    this.orderIndex = 0,
    this.isPrimary = false,
    this.moderationStatus = 'pending',
    DateTime? uploadedAt,
  }) : uploadedAt = uploadedAt ?? DateTime.now();

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) {
    return ProfilePhoto(
      id: json['id'] ?? '',
      profileId: json['profile_id'] ?? '',
      storagePath: json['storage_path'] ?? '',
      thumbnailPath: json['thumbnail_path'],
      orderIndex: json['order_index'] ?? 0,
      isPrimary: json['is_primary'] ?? false,
      moderationStatus: json['moderation_status'] ?? 'pending',
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.parse(json['uploaded_at'])
          : DateTime.now(),
    );
  }
}

class PartnerPreferences {
  final int ageMin;
  final int ageMax;
  final int? heightMinCm;
  final int? heightMaxCm;
  final List<int>? sectIds;
  final List<int>? casteIds;
  final List<String>? countryCodes;
  final List<String>? maritalStatuses;
  final String? educationMin;
  final String? religiosityMin;
  final bool? hijabRequired;

  PartnerPreferences({
    this.ageMin = 18,
    this.ageMax = 45,
    this.heightMinCm,
    this.heightMaxCm,
    this.sectIds,
    this.casteIds,
    this.countryCodes,
    this.maritalStatuses,
    this.educationMin,
    this.religiosityMin,
    this.hijabRequired,
  });

  factory PartnerPreferences.fromJson(Map<String, dynamic> json) {
    return PartnerPreferences(
      ageMin: json['age_min'] ?? 18,
      ageMax: json['age_max'] ?? 45,
      heightMinCm: json['height_min_cm'],
      heightMaxCm: json['height_max_cm'],
      sectIds: json['sect_ids'] != null
          ? List<int>.from(json['sect_ids'])
          : null,
      casteIds: json['caste_ids'] != null
          ? List<int>.from(json['caste_ids'])
          : null,
      countryCodes: json['country_codes'] != null
          ? List<String>.from(json['country_codes'])
          : null,
      maritalStatuses: json['marital_statuses'] != null
          ? List<String>.from(json['marital_statuses'])
          : null,
      educationMin: json['education_min'],
      religiosityMin: json['religiosity_min'],
      hijabRequired: json['hijab_required'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age_min': ageMin,
      'age_max': ageMax,
      'height_min_cm': heightMinCm,
      'height_max_cm': heightMaxCm,
      'sect_ids': sectIds,
      'caste_ids': casteIds,
      'country_codes': countryCodes,
      'marital_statuses': maritalStatuses,
      'education_min': educationMin,
      'religiosity_min': religiosityMin,
      'hijab_required': hijabRequired,
    };
  }
}
