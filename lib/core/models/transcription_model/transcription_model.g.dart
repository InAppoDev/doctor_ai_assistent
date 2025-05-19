// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranscriptionModelImpl _$$TranscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TranscriptionModelImpl(
      speaker: (json['speaker'] as num).toInt(),
      transcription: json['transcription'] as String,
      time: (json['time'] as num).toDouble(),
    );

Map<String, dynamic> _$$TranscriptionModelImplToJson(
        _$TranscriptionModelImpl instance) =>
    <String, dynamic>{
      'speaker': instance.speaker,
      'transcription': instance.transcription,
      'time': instance.time,
    };
