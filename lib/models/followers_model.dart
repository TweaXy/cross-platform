class FollowersModel {
  int id;
  String name;
  String username;
  String avatar;
  String bio;
  bool? status;
  FollowersModel({
    required this.avatar,
    required this.bio,
    required this.id,
    required this.name,
    this.status,
    required this.username,
  });
  factory FollowersModel.fromJson(dynamic data) {
    var jsonData = data['data'];
    return FollowersModel(
        id: jsonData['id'],
        username: jsonData['username'],
        avatar: jsonData['avatar'],
        name: jsonData['name'],
        bio: jsonData['bio'],
        status: jsonData["status"]);
  }
  factory FollowersModel.fromJsoning(dynamic data) {
    var jsonData = data['data'];
    return FollowersModel(
      id: jsonData['id'],
      username: jsonData['username'],
      avatar: jsonData['avatar'],
      name: jsonData['name'],
      bio: jsonData['bio'],
    );
  }
}
