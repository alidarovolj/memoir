// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalDataModelImpl _$$PersonalDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$PersonalDataModelImpl(
  profession: json['profession'] as String?,
  telegramUrl: json['telegram_url'] as String?,
  whatsappUrl: json['whatsapp_url'] as String?,
  youtubeUrl: json['youtube_url'] as String?,
  linkedinUrl: json['linkedin_url'] as String?,
  aboutMe: json['about_me'] as String?,
  city: json['city'] as String?,
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  education: json['education'] as String?,
  hobbies: json['hobbies'] as String?,
);

Map<String, dynamic> _$$PersonalDataModelImplToJson(
  _$PersonalDataModelImpl instance,
) => <String, dynamic>{
  'profession': instance.profession,
  'telegram_url': instance.telegramUrl,
  'whatsapp_url': instance.whatsappUrl,
  'youtube_url': instance.youtubeUrl,
  'linkedin_url': instance.linkedinUrl,
  'about_me': instance.aboutMe,
  'city': instance.city,
  'date_of_birth': instance.dateOfBirth?.toIso8601String(),
  'education': instance.education,
  'hobbies': instance.hobbies,
};
