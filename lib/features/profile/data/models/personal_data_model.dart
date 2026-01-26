import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_data_model.freezed.dart';
part 'personal_data_model.g.dart';

@freezed
class PersonalDataModel with _$PersonalDataModel {
  const factory PersonalDataModel({
    String? profession,
    @JsonKey(name: 'telegram_url') String? telegramUrl,
    @JsonKey(name: 'whatsapp_url') String? whatsappUrl,
    @JsonKey(name: 'youtube_url') String? youtubeUrl,
    @JsonKey(name: 'linkedin_url') String? linkedinUrl,
    @JsonKey(name: 'about_me') String? aboutMe,
    String? city,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    String? education,
    String? hobbies,
  }) = _PersonalDataModel;

  factory PersonalDataModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalDataModelFromJson(json);
}
