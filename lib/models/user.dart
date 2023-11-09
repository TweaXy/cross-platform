import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id;
  String? userName;
  String? name;
  String? email;
  String? avatar;
  String? cover;
  String? phone;
  String? birthdayDate;
  String? joinedDate;
  String? bio;
  String? website;
  String? location;
  int? followers;
  int? following;
  User({
    this.id,
    this.userName,
    this.name,
    this.email,
    this.avatar,
    this.cover,
    this.phone,
    this.birthdayDate,
    this.joinedDate,
    this.bio,
    this.website,
    this.location,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'name': name,
      'email': email,
      'avatar': avatar,
      'cover': cover,
      'phone': phone,
      'birthdayDate': birthdayDate,
      'joinedDate': joinedDate,
      'bio': bio,
      'website': website,
      'location': location,
      'followers': followers,
      'following': following,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      userName: map['username'] != null ? map['username'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      birthdayDate:
          map['birthdayDate'] != null ? map['birthdayDate'] as String : null,
      joinedDate:
          map['joinedDate'] != null ? map['joinedDate'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      followers: map['_count']['followedBy'] != null
          ? map['_count']['followedBy'] as int
          : null,
      following: map['_count']['following'] != null
          ? map['_count']['following'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
