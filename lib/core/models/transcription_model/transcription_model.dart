import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcription_model.freezed.dart';
part 'transcription_model.g.dart';

@freezed
class TranscriptionModel with _$TranscriptionModel {
  const factory TranscriptionModel({
    required int speaker,
    required String transcription,
    required double time,
  }) = _TranscriptionModel;

  factory TranscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$TranscriptionModelFromJson(json);
}
