import 'package:freezed_annotation/freezed_annotation.dart';
import '../role/role.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required final int id,
    required final String email,
    final String? passwordResetToken,
    final String? name,
    final List<Role>? roles,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
