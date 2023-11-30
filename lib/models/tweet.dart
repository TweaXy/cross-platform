class Tweet {
  final String? userImage;
  final List <String>? image;
  final String userName;
  final String userHandle;
  final String time;
  final String? tweetText;
  final String id;
  final String userId;
  final int likesCount;
  final int viewsCount;
  final int retweetsCount;
  final int commentsCount;
  //+++++++++video
  const Tweet({
    required this.userImage,
    required this.image,
    required this.userName,
    required this.userHandle,
    required this.time,
    required this.tweetText,
    required this.id,
    required this.userId,
    required this.likesCount,
    required this.viewsCount,
    required this.retweetsCount,
    required this.commentsCount,
  });
  String getId() {
    return id;
  }

  String getUserId() {
    return userId;
  }
}
