import 'dart:convert';

class User {
  String? id;
  String? username;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? location;
  String? bio;
  String? avatar;
  String? cover;
  String? website;
  DateTime? joinedAt;
  String? birthdayDate;

  User({
    this.id,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.location,
    this.website,
    this.joinedAt,
    this.birthdayDate,
    this.avatar,
    this.bio,
    this.cover,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as String?,
        username: data['username'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        password: data['password'] as String?,
        location: data['location'] as String?,
        website: data['website'] as String?,
        joinedAt: data['joinedAt'] == null
            ? null
            : DateTime.parse(data['joinedAt'] as String),
        birthdayDate: data['birthdayDate'] as String?,
        bio: data['bio'],
        avatar: data['avatar'],
        cover: data['cover'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'location': location,
        'website': website,
        'joinedAt': joinedAt?.toIso8601String(),
        'birthdayDate': birthdayDate,
        'bio':bio,
        'avatar':avatar,
        'cover':cover,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
