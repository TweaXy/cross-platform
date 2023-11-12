class UsersModel {
  UsersModel(
      {required this.email,
      this.avatar,
      required this.username,
      required this.phone,
      required this.name});
  final String username;
  final String name;
  final String email;
  String? avatar;
  final String phone;
  factory UsersModel.fromJson(dynamic data) {
    var jsonData = data['data'];
    return UsersModel(
        email: jsonData['email'],
        username: jsonData['username'],
        phone: jsonData['phone'],
        name: jsonData['name'],
        avatar: jsonData['avatar']);
  }
}
