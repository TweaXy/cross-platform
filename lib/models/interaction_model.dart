class Interaction {
  String? id;
  String? type;
  String? text;
  String? tweetId;
  String? userID;


  Interaction({this.id, this.type, this.text, this.tweetId, this.userID});

  Interaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    text = json['text'];

    tweetId = json['parentInteractionID'];
    userID = json['userID'];
  }
}
