// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$$_LoginResponseFromJson(Map<String, dynamic> json) =>
    _$_LoginResponse(
      success: json['success'],
      status: json['status'] as String?,
      message: json['message'] as String?,
      payload: json['payload'] == null
          ? null
          : LoginPayload.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'payload': instance.payload,
    };

_$_LoginPayload _$$_LoginPayloadFromJson(Map<String, dynamic> json) =>
    _$_LoginPayload(
      accessToken: json['accessToken'] as String?,
      tokenType: json['tokenType'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LoginPayloadToJson(_$_LoginPayload instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
