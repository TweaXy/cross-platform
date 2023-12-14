import 'package:tweaxy/models/interaction_model.dart';
import 'package:tweaxy/models/user.dart';

class UserNotification {
  String? userId;
  String? userName;
  String? name;
  String? action;
  String? avatar;
  String? date;
  Interaction? interaction;

  UserNotification(
      {this.userId,
      this.name,
      this.action,
      this.avatar,
      this.date,
      this.interaction});

  UserNotification.fromJson(Map<String, dynamic> json) {
    userName = json['fromUser']['username'];
    userId = json['fromUser']['id'];
    name = json['fromUser']['name'];
    action = json['action'].toLowerCase();
    avatar = json['fromUser']['avatar'];
    date = json['createdDate'];
    interaction = json['interaction'] == null
        ? null
        : Interaction.fromJson(json['interaction']);
  }
}
