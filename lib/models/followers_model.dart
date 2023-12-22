class FollowersModel {
  String id;
  String name;
  String username;
  String avatar;
  String? bio;
  bool? status;
  bool followesMe;
  bool followedByMe;
  bool blocksMe = false;
  bool blockedByMe = false;
  FollowersModel({
    required this.avatar,
    required this.bio,
    required this.id,
    required this.name,
    this.status,
    required this.username,
    required this.followedByMe,
    required this.followesMe,
    this.blocksMe = false,
    this.blockedByMe = false,
  });
  factory FollowersModel.fromJson(dynamic data) {
    var jsonData = data;
    return FollowersModel(
      id: jsonData['id'],
      username: jsonData['username'],
      avatar: jsonData['avatar'],
      name: jsonData['name'],
      bio: jsonData['bio'],
      status: jsonData["status"],
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
      blocksMe: jsonData["blocksMe"],
      blockedByMe: jsonData["blockedByMe"],
    );
  }
  factory FollowersModel.fromJsonLikers(dynamic data) {
    var jsonData = data['user'];
    return FollowersModel(
      id: jsonData['id'],
      username: jsonData['username'],
      avatar: jsonData['avatar'],
      name: jsonData['name'],
      bio: jsonData['bio'],
      status: jsonData["status"],
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
      blocksMe: jsonData["blocksMe"],
      blockedByMe: jsonData["blockedByMe"],
    );
  }
  factory FollowersModel.fromJsoning(dynamic data) {
    var jsonData = data;
    return FollowersModel(
      id: jsonData['id'],
      username: jsonData['username'],
      avatar: jsonData['avatar'],
      name: jsonData['name'],
      bio: jsonData['bio'],
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
      blocksMe: jsonData["blocksMe"],
      blockedByMe: jsonData["blockedByMe"],
    );
  }
  factory FollowersModel.fromJsonIncide(dynamic data) {
    var jsonData = data;
    if (jsonData['avatar'] == null) {
      jsonData['avatar'] = "b631858bdaafa77258b9ed2f7c689bdb.png";
    }
    return FollowersModel(
      id: jsonData['id'],
      username: jsonData['username'],
      avatar: jsonData['avatar'],
      name: jsonData['name'],
      bio: jsonData['bio'],
      status: jsonData["status"],
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
    );
  }
}
