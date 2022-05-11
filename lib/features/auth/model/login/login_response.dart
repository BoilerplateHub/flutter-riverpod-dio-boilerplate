import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../app/model/user/user.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    dynamic success,
    final String? status,
    final String? message,
    final LoginPayload? payload,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class LoginPayload with _$LoginPayload {
  const factory LoginPayload({
    final String? accessToken,
    final String? tokenType,
    final String? refreshToken,
    final User? user,
  }) = _LoginPayload;

  factory LoginPayload.fromJson(Map<String, dynamic> json) =>
      _$LoginPayloadFromJson(json);
}
