class UserNotification {
  String? userId;
  String? interactionId;
  String? name;
  String? action;
  String? avatar;
  String? date;
  String? interaction;

  UserNotification(
      {this.userId,
      this.interactionId,
      this.name,
      this.action,
      this.avatar,
      this.date,
      this.interaction});

  UserNotification.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    interactionId = json['interactionId'];
    name = json['name'];
    action = json['action'];
    avatar = json['avatar'];
    date = json['date'];
    interaction = json['interaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['interactionId'] = this.interactionId;
    data['name'] = this.name;
    data['action'] = this.action;
    data['avatar'] = this.avatar;
    data['date'] = this.date;
    data['interaction'] = this.interaction;
    return data;
  }
}
