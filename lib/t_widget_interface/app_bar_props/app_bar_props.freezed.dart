// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_bar_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppBarProps _$AppBarPropsFromJson(Map<String, dynamic> json) {
  return _AppBarProps.fromJson(json);
}

/// @nodoc
mixin _$AppBarProps {
  LayoutProps? get content => throw _privateConstructorUsedError;
  LayoutProps? get custom => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppBarPropsCopyWith<AppBarProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBarPropsCopyWith<$Res> {
  factory $AppBarPropsCopyWith(
          AppBarProps value, $Res Function(AppBarProps) then) =
      _$AppBarPropsCopyWithImpl<$Res>;
  $Res call({LayoutProps? content, LayoutProps? custom});

  $LayoutPropsCopyWith<$Res>? get content;
  $LayoutPropsCopyWith<$Res>? get custom;
}

/// @nodoc
class _$AppBarPropsCopyWithImpl<$Res> implements $AppBarPropsCopyWith<$Res> {
  _$AppBarPropsCopyWithImpl(this._value, this._then);

  final AppBarProps _value;
  // ignore: unused_field
  final $Res Function(AppBarProps) _then;

  @override
  $Res call({
    Object? content = freezed,
    Object? custom = freezed,
  }) {
    return _then(_value.copyWith(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
      custom: custom == freezed
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
    ));
  }

  @override
  $LayoutPropsCopyWith<$Res>? get content {
    if (_value.content == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.content!, (value) {
      return _then(_value.copyWith(content: value));
    });
  }

  @override
  $LayoutPropsCopyWith<$Res>? get custom {
    if (_value.custom == null) {
      return null;
    }

    return $LayoutPropsCopyWith<$Res>(_value.custom!, (value) {
      return _then(_value.copyWith(custom: value));
    });
  }
}

/// @nodoc
abstract class _$$_AppBarPropsCopyWith<$Res>
    implements $AppBarPropsCopyWith<$Res> {
  factory _$$_AppBarPropsCopyWith(
          _$_AppBarProps value, $Res Function(_$_AppBarProps) then) =
      __$$_AppBarPropsCopyWithImpl<$Res>;
  @override
  $Res call({LayoutProps? content, LayoutProps? custom});

  @override
  $LayoutPropsCopyWith<$Res>? get content;
  @override
  $LayoutPropsCopyWith<$Res>? get custom;
}

/// @nodoc
class __$$_AppBarPropsCopyWithImpl<$Res> extends _$AppBarPropsCopyWithImpl<$Res>
    implements _$$_AppBarPropsCopyWith<$Res> {
  __$$_AppBarPropsCopyWithImpl(
      _$_AppBarProps _value, $Res Function(_$_AppBarProps) _then)
      : super(_value, (v) => _then(v as _$_AppBarProps));

  @override
  _$_AppBarProps get _value => super._value as _$_AppBarProps;

  @override
  $Res call({
    Object? content = freezed,
    Object? custom = freezed,
  }) {
    return _then(_$_AppBarProps(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
      custom: custom == freezed
          ? _value.custom
          : custom // ignore: cast_nullable_to_non_nullable
              as LayoutProps?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppBarProps with DiagnosticableTreeMixin implements _AppBarProps {
  const _$_AppBarProps({this.content, this.custom});

  factory _$_AppBarProps.fromJson(Map<String, dynamic> json) =>
      _$$_AppBarPropsFromJson(json);

  @override
  final LayoutProps? content;
  @override
  final LayoutProps? custom;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppBarProps(content: $content, custom: $custom)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppBarProps'))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('custom', custom));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppBarProps &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.custom, custom));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(custom));

  @JsonKey(ignore: true)
  @override
  _$$_AppBarPropsCopyWith<_$_AppBarProps> get copyWith =>
      __$$_AppBarPropsCopyWithImpl<_$_AppBarProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppBarPropsToJson(this);
  }
}

abstract class _AppBarProps implements AppBarProps {
  const factory _AppBarProps(
      {final LayoutProps? content, final LayoutProps? custom}) = _$_AppBarProps;

  factory _AppBarProps.fromJson(Map<String, dynamic> json) =
      _$_AppBarProps.fromJson;

  @override
  LayoutProps? get content;
  @override
  LayoutProps? get custom;
  @override
  @JsonKey(ignore: true)
  _$$_AppBarPropsCopyWith<_$_AppBarProps> get copyWith =>
      throw _privateConstructorUsedError;
}
