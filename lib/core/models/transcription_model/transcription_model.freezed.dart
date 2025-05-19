// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranscriptionModel _$TranscriptionModelFromJson(Map<String, dynamic> json) {
  return _TranscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$TranscriptionModel {
  int get speaker => throw _privateConstructorUsedError;
  String get transcription => throw _privateConstructorUsedError;
  double get time => throw _privateConstructorUsedError;

  /// Serializes this TranscriptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranscriptionModelCopyWith<TranscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranscriptionModelCopyWith<$Res> {
  factory $TranscriptionModelCopyWith(
          TranscriptionModel value, $Res Function(TranscriptionModel) then) =
      _$TranscriptionModelCopyWithImpl<$Res, TranscriptionModel>;
  @useResult
  $Res call({int speaker, String transcription, double time});
}

/// @nodoc
class _$TranscriptionModelCopyWithImpl<$Res, $Val extends TranscriptionModel>
    implements $TranscriptionModelCopyWith<$Res> {
  _$TranscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speaker = null,
    Object? transcription = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as int,
      transcription: null == transcription
          ? _value.transcription
          : transcription // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranscriptionModelImplCopyWith<$Res>
    implements $TranscriptionModelCopyWith<$Res> {
  factory _$$TranscriptionModelImplCopyWith(_$TranscriptionModelImpl value,
          $Res Function(_$TranscriptionModelImpl) then) =
      __$$TranscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int speaker, String transcription, double time});
}

/// @nodoc
class __$$TranscriptionModelImplCopyWithImpl<$Res>
    extends _$TranscriptionModelCopyWithImpl<$Res, _$TranscriptionModelImpl>
    implements _$$TranscriptionModelImplCopyWith<$Res> {
  __$$TranscriptionModelImplCopyWithImpl(_$TranscriptionModelImpl _value,
      $Res Function(_$TranscriptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speaker = null,
    Object? transcription = null,
    Object? time = null,
  }) {
    return _then(_$TranscriptionModelImpl(
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as int,
      transcription: null == transcription
          ? _value.transcription
          : transcription // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranscriptionModelImpl implements _TranscriptionModel {
  const _$TranscriptionModelImpl(
      {required this.speaker, required this.transcription, required this.time});

  factory _$TranscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranscriptionModelImplFromJson(json);

  @override
  final int speaker;
  @override
  final String transcription;
  @override
  final double time;

  @override
  String toString() {
    return 'TranscriptionModel(speaker: $speaker, transcription: $transcription, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranscriptionModelImpl &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.transcription, transcription) ||
                other.transcription == transcription) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, speaker, transcription, time);

  /// Create a copy of TranscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranscriptionModelImplCopyWith<_$TranscriptionModelImpl> get copyWith =>
      __$$TranscriptionModelImplCopyWithImpl<_$TranscriptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _TranscriptionModel implements TranscriptionModel {
  const factory _TranscriptionModel(
      {required final int speaker,
      required final String transcription,
      required final double time}) = _$TranscriptionModelImpl;

  factory _TranscriptionModel.fromJson(Map<String, dynamic> json) =
      _$TranscriptionModelImpl.fromJson;

  @override
  int get speaker;
  @override
  String get transcription;
  @override
  double get time;

  /// Create a copy of TranscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranscriptionModelImplCopyWith<_$TranscriptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
