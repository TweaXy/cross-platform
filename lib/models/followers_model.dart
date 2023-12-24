class FollowersModel {
  String id;
  String name;
  String username;
  String avatar;
  String? bio;
  bool followesMe;
  bool followedByMe;
  bool blocksMe = false;
  bool blockedByMe = false;
  FollowersModel({
    required this.avatar,
    required this.bio,
    required this.id,
    required this.name,
    required this.username,
    required this.followedByMe,
    required this.followesMe,
    this.blocksMe = false,
    this.blockedByMe = false,
  });
  factory FollowersModel.fromJson(dynamic data) {
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
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
      blocksMe: jsonData["blocksMe"],
      blockedByMe: jsonData["blockedByMe"],
    );
  }
  factory FollowersModel.fromJsonLikers(dynamic data) {
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
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
    );
  }
  factory FollowersModel.fromJsoning(dynamic data) {
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
      followedByMe: jsonData["followedByMe"],
      followesMe: jsonData["followsMe"],
    );
  }
}
