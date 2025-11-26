import 'dart:convert';

class UserModel {
  final String id;
  String name;
  final String email;
  String? photoUrl;

  UserModel({required this.id, required this.name, required this.email, this.photoUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        photoUrl: json['photoUrl'] as String?,
      );

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));
}
