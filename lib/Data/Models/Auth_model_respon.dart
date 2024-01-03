import 'dart:convert';

class AuthResponModel {
    final String jwtToken;
    final User user;

    AuthResponModel({
        required this.jwtToken,
        required this.user,
    });

    factory AuthResponModel.fromJson(String str) => AuthResponModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponModel.fromMap(Map<String, dynamic> json) => AuthResponModel(
        jwtToken: json["jwt-token"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "jwt-token": jwtToken,
        "user": user.toMap(),
    };
}

class User {
    final int id;
    final String name;
    final String roles;

    User({
        required this.id,
        required this.name,
        required this.roles,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        roles: json["roles"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "roles": roles,
    };
}
