import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User(
        this.username,
        this.userEmail,
        this.isLogin,
        );

    String username;
    String userEmail;
    bool isLogin;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);

    User.empty();
}
