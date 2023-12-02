import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class LikeTweet {
  static final String _endpoint = 'interactions/';
  LikeTweet._();
  static Future<bool> likeTweet(String id, String token) async {
    var dio = Dio();
    var response = await dio.post(
      '$baseURL$_endpoint$id/like',
      options: Options(headers: {'Authorization': token}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
    static Future<bool> unLikeTweet(String id, String token) async {
    var dio = Dio();
    var response = await dio.delete(
      '$baseURL$_endpoint$id/like',
      options: Options(headers: {'Authorization': token}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
