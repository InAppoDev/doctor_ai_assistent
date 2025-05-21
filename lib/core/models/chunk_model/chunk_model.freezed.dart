// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chunk_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChunkModel _$ChunkModelFromJson(Map<String, dynamic> json) {
  return _ChunkModel.fromJson(json);
}

/// @nodoc
mixin _$ChunkModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: true)
  String? get translatedTranscription => throw _privateConstructorUsedError;
  String get speaker => throw _privateConstructorUsedError;
  String get transcription => throw _privateConstructorUsedError;
  double get time => throw _privateConstructorUsedError;
  int get log => throw _privateConstructorUsedError;

  /// Serializes this ChunkModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChunkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChunkModelCopyWith<ChunkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChunkModelCopyWith<$Res> {
  factory $ChunkModelCopyWith(
          ChunkModel value, $Res Function(ChunkModel) then) =
      _$ChunkModelCopyWithImpl<$Res, ChunkModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: true)
      String? translatedTranscription,
      String speaker,
      String transcription,
      double time,
      int log});
}

/// @nodoc
class _$ChunkModelCopyWithImpl<$Res, $Val extends ChunkModel>
    implements $ChunkModelCopyWith<$Res> {
  _$ChunkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChunkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? translatedTranscription = freezed,
    Object? speaker = null,
    Object? transcription = null,
    Object? time = null,
    Object? log = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      translatedTranscription: freezed == translatedTranscription
          ? _value.translatedTranscription
          : translatedTranscription // ignore: cast_nullable_to_non_nullable
              as String?,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      transcription: null == transcription
          ? _value.transcription
          : transcription // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as double,
      log: null == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChunkModelImplCopyWith<$Res>
    implements $ChunkModelCopyWith<$Res> {
  factory _$$ChunkModelImplCopyWith(
          _$ChunkModelImpl value, $Res Function(_$ChunkModelImpl) then) =
      __$$ChunkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: true)
      String? translatedTranscription,
      String speaker,
      String transcription,
      double time,
      int log});
}

/// @nodoc
class __$$ChunkModelImplCopyWithImpl<$Res>
    extends _$ChunkModelCopyWithImpl<$Res, _$ChunkModelImpl>
    implements _$$ChunkModelImplCopyWith<$Res> {
  __$$ChunkModelImplCopyWithImpl(
      _$ChunkModelImpl _value, $Res Function(_$ChunkModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChunkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? translatedTranscription = freezed,
    Object? speaker = null,
    Object? transcription = null,
    Object? time = null,
    Object? log = null,
  }) {
    return _then(_$ChunkModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      translatedTranscription: freezed == translatedTranscription
          ? _value.translatedTranscription
          : translatedTranscription // ignore: cast_nullable_to_non_nullable
              as String?,
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      transcription: null == transcription
          ? _value.transcription
          : transcription // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as double,
      log: null == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChunkModelImpl implements _ChunkModel {
  const _$ChunkModelImpl(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: true)
      this.translatedTranscription,
      required this.speaker,
      required this.transcription,
      required this.time,
      required this.log});

  factory _$ChunkModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChunkModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? translatedTranscription;
  @override
  final String speaker;
  @override
  final String transcription;
  @override
  final double time;
  @override
  final int log;

  @override
  String toString() {
    return 'ChunkModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, translatedTranscription: $translatedTranscription, speaker: $speaker, transcription: $transcription, time: $time, log: $log)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChunkModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(
                    other.translatedTranscription, translatedTranscription) ||
                other.translatedTranscription == translatedTranscription) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.transcription, transcription) ||
                other.transcription == transcription) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.log, log) || other.log == log));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      translatedTranscription, speaker, transcription, time, log);

  /// Create a copy of ChunkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChunkModelImplCopyWith<_$ChunkModelImpl> get copyWith =>
      __$$ChunkModelImplCopyWithImpl<_$ChunkModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChunkModelImplToJson(
      this,
    );
  }
}

abstract class _ChunkModel implements ChunkModel {
  const factory _ChunkModel(
      {required final int id,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(includeFromJson: false, includeToJson: true)
      final String? translatedTranscription,
      required final String speaker,
      required final String transcription,
      required final double time,
      required final int log}) = _$ChunkModelImpl;

  factory _ChunkModel.fromJson(Map<String, dynamic> json) =
      _$ChunkModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: true)
  String? get translatedTranscription;
  @override
  String get speaker;
  @override
  String get transcription;
  @override
  double get time;
  @override
  int get log;

  /// Create a copy of ChunkModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChunkModelImplCopyWith<_$ChunkModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
