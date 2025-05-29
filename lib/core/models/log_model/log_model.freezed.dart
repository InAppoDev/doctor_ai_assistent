// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LogModel _$LogModelFromJson(Map<String, dynamic> json) {
  return _LogModel.fromJson(json);
}

/// @nodoc
mixin _$LogModel {
  int get id => throw _privateConstructorUsedError;
  String get audio => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  double get duration => throw _privateConstructorUsedError;
  int get form => throw _privateConstructorUsedError;
  int get appointment => throw _privateConstructorUsedError;
  List<ChunkModel> get chunks => throw _privateConstructorUsedError;

  /// Serializes this LogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogModelCopyWith<LogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogModelCopyWith<$Res> {
  factory $LogModelCopyWith(LogModel value, $Res Function(LogModel) then) =
      _$LogModelCopyWithImpl<$Res, LogModel>;
  @useResult
  $Res call(
      {int id,
      String audio,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      String key,
      double duration,
      int form,
      int appointment,
      List<ChunkModel> chunks});
}

/// @nodoc
class _$LogModelCopyWithImpl<$Res, $Val extends LogModel>
    implements $LogModelCopyWith<$Res> {
  _$LogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? audio = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? key = null,
    Object? duration = null,
    Object? form = null,
    Object? appointment = null,
    Object? chunks = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as int,
      appointment: null == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as int,
      chunks: null == chunks
          ? _value.chunks
          : chunks // ignore: cast_nullable_to_non_nullable
              as List<ChunkModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogModelImplCopyWith<$Res>
    implements $LogModelCopyWith<$Res> {
  factory _$$LogModelImplCopyWith(
          _$LogModelImpl value, $Res Function(_$LogModelImpl) then) =
      __$$LogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String audio,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      String key,
      double duration,
      int form,
      int appointment,
      List<ChunkModel> chunks});
}

/// @nodoc
class __$$LogModelImplCopyWithImpl<$Res>
    extends _$LogModelCopyWithImpl<$Res, _$LogModelImpl>
    implements _$$LogModelImplCopyWith<$Res> {
  __$$LogModelImplCopyWithImpl(
      _$LogModelImpl _value, $Res Function(_$LogModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? audio = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? key = null,
    Object? duration = null,
    Object? form = null,
    Object? appointment = null,
    Object? chunks = null,
  }) {
    return _then(_$LogModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      audio: null == audio
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as int,
      appointment: null == appointment
          ? _value.appointment
          : appointment // ignore: cast_nullable_to_non_nullable
              as int,
      chunks: null == chunks
          ? _value._chunks
          : chunks // ignore: cast_nullable_to_non_nullable
              as List<ChunkModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogModelImpl implements _LogModel {
  const _$LogModelImpl(
      {required this.id,
      required this.audio,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      required this.key,
      required this.duration,
      required this.form,
      required this.appointment,
      required final List<ChunkModel> chunks})
      : _chunks = chunks;

  factory _$LogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogModelImplFromJson(json);

  @override
  final int id;
  @override
  final String audio;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  final String key;
  @override
  final double duration;
  @override
  final int form;
  @override
  final int appointment;
  final List<ChunkModel> _chunks;
  @override
  List<ChunkModel> get chunks {
    if (_chunks is EqualUnmodifiableListView) return _chunks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chunks);
  }

  @override
  String toString() {
    return 'LogModel(id: $id, audio: $audio, createdAt: $createdAt, updatedAt: $updatedAt, key: $key, duration: $duration, form: $form, appointment: $appointment, chunks: $chunks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.audio, audio) || other.audio == audio) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment) &&
            const DeepCollectionEquality().equals(other._chunks, _chunks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      audio,
      createdAt,
      updatedAt,
      key,
      duration,
      form,
      appointment,
      const DeepCollectionEquality().hash(_chunks));

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogModelImplCopyWith<_$LogModelImpl> get copyWith =>
      __$$LogModelImplCopyWithImpl<_$LogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogModelImplToJson(
      this,
    );
  }
}

abstract class _LogModel implements LogModel {
  const factory _LogModel(
      {required final int id,
      required final String audio,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      required final String key,
      required final double duration,
      required final int form,
      required final int appointment,
      required final List<ChunkModel> chunks}) = _$LogModelImpl;

  factory _LogModel.fromJson(Map<String, dynamic> json) =
      _$LogModelImpl.fromJson;

  @override
  int get id;
  @override
  String get audio;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  String get key;
  @override
  double get duration;
  @override
  int get form;
  @override
  int get appointment;
  @override
  List<ChunkModel> get chunks;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogModelImplCopyWith<_$LogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
