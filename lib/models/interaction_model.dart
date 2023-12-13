class Interaction {
  String? id;
  String? type;
  String? text;

  String? parentInteractionID;
  String? userID;

  Interaction(
      {this.id, this.type, this.text, this.parentInteractionID, this.userID});

  Interaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    text = json['text'];

    parentInteractionID = json['parentInteractionID'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['text'] = this.text;
    data['parentInteractionID'] = this.parentInteractionID;
    data['userID'] = this.userID;
    return data;
  }
}