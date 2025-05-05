// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      birth: DateTime.parse(json['birth'] as String),
      when: DateTime.parse(json['when'] as String),
      user: (json['user'] as num).toInt(),
    );

Map<String, dynamic> _$$AppointmentModelImplToJson(
        _$AppointmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': _toIso(instance.createdAt),
      'updated_at': _toIso(instance.updatedAt),
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'birth': _toIso(instance.birth),
      'when': _toIso(instance.when),
      'user': instance.user,
    };
