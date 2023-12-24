import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';

class LikeTweet {
  static final String _endpoint = 'interactions/';
  LikeTweet._();
  static Future<bool> likeTweet(String id, String token) async {
    var dio = Dio();
    print(id);
    try {
      var response = await dio.post(
        '$baseURL$_endpoint$id/like',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print('Liked');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> unLikeTweet(String id, String token) async {
    var dio = Dio();
    var response = await dio.delete(
      '$baseURL$_endpoint$id/like',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.statusCode == 200) {
      print('UnLiked');

      return false;
    } else {
      return true;
    }
  }
}
