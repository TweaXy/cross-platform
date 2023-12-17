class UserChat {
  String id;
  String? name = 'hassan';
  String? email;
  String username;
  String? avatar;
  UserChat(
      {required this.id,
      this.email,
      required this.username,
      this.avatar,
      this.name});
  factory UserChat.fromJson(dynamic data) {
    var jsonData = data;
    return UserChat(
      id: jsonData['id'],
      username: jsonData['username'],
      email: jsonData['email'],
    );
  }
  factory UserChat.fromJsonSearch(dynamic data, int i) {
    var jsonData = data;
    return UserChat(
      id: jsonData['id'],
      username: jsonData['username'],
      name: jsonData['name'],
    );
  }
}
