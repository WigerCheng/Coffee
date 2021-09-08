import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class User {
  String account;
  String password;
  String userName;
  @JsonKey(nullable: true)
  String phone;
  @JsonKey(nullable: true)
  String sex;
  @JsonKey(nullable: true, name: "status")
  int type;
  int userId;

  User.login(this.account, this.password);

  User(
      {this.account,
      this.password,
      this.userName,
      this.phone,
      this.sex,
      this.type,
      this.userId});

  String typeStr() => type == USER_MANAGER ? "管理员" : "顾客";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// 顾客
  static const USER_CUSTOMER = 0;

  /// 管理员
  static const USER_MANAGER = 1;
}
