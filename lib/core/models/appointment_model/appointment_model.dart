import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required int id,
    @JsonKey(name: 'created_at', fromJson: DateTime.parse, toJson: _toIso)
    required DateTime createdAt,
    @JsonKey(name: 'updated_at', fromJson: DateTime.parse, toJson: _toIso)
    required DateTime updatedAt,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(fromJson: DateTime.parse, toJson: _toIso) required DateTime birth,
    @JsonKey(fromJson: DateTime.parse, toJson: _toIso) required DateTime when,
    required int user,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}

String _toIso(DateTime date) => date.toIso8601String();
