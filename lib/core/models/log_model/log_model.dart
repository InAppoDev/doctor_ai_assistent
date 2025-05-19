import 'package:ecnx_ambient_listening/core/models/chunk_model/chunk_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_model.freezed.dart';
part 'log_model.g.dart';

@freezed
class LogModel with _$LogModel {
  const factory LogModel({
    required int id,
    required String audio,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required String key,
    required double duration,
    required int form,
    required int appointment,
    required List<ChunkModel> chunks,
  }) = _LogModel;

  factory LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);
}
