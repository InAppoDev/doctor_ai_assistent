// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogModelImpl _$$LogModelImplFromJson(Map<String, dynamic> json) =>
    _$LogModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      transcription: json['transcription'] as String,
      speaker: json['speaker'] as String,
      appointment: (json['appointment'] as num).toInt(),
      form: (json['form'] as num).toInt(),
    );

Map<String, dynamic> _$$LogModelImplToJson(_$LogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'transcription': instance.transcription,
      'speaker': instance.speaker,
      'appointment': instance.appointment,
      'form': instance.form,
    };
