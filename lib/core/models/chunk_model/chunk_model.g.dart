// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChunkModelImpl _$$ChunkModelImplFromJson(Map<String, dynamic> json) =>
    _$ChunkModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      speaker: json['speaker'] as String,
      transcription: json['transcription'] as String,
      time: (json['time'] as num).toInt(),
      log: (json['log'] as num).toInt(),
    );

Map<String, dynamic> _$$ChunkModelImplToJson(_$ChunkModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'speaker': instance.speaker,
      'transcription': instance.transcription,
      'time': instance.time,
      'log': instance.log,
    };
