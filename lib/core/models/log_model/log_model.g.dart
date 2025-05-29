// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogModelImpl _$$LogModelImplFromJson(Map<String, dynamic> json) =>
    _$LogModelImpl(
      id: (json['id'] as num).toInt(),
      audio: json['audio'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      key: json['key'] as String,
      duration: (json['duration'] as num).toDouble(),
      form: (json['form'] as num).toInt(),
      appointment: (json['appointment'] as num).toInt(),
      chunks: (json['chunks'] as List<dynamic>)
          .map((e) => ChunkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LogModelImplToJson(_$LogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'audio': instance.audio,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'key': instance.key,
      'duration': instance.duration,
      'form': instance.form,
      'appointment': instance.appointment,
      'chunks': instance.chunks,
    };
