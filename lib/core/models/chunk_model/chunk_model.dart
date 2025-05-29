import 'package:freezed_annotation/freezed_annotation.dart';

part 'chunk_model.freezed.dart';
part 'chunk_model.g.dart';

@freezed
class ChunkModel with _$ChunkModel {
  const factory ChunkModel({
    required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(includeFromJson: false, includeToJson: true)
    String? translatedTranscription,
    required String speaker,
    required String transcription,
    required double time,
    required int log,
  }) = _ChunkModel;

  factory ChunkModel.fromJson(Map<String, dynamic> json) =>
      _$ChunkModelFromJson(json);
}
