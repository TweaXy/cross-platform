import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempUser {
  TempUser._();
  static int notificationCount = 0;
  static TempUser? _instance;
  static String email = '';
  static String id = '';
  static String token = '';
  static String username = '';
  static String name = '';
  static String image = 'b631858bdaafa77258b9ed2f7c689bdb.png';
  // String baseURL = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    TempUser.email = email;
  }

  static void setToken({required String token}) {
    TempUser.token = token;
  }

  static void setUserName({required String username}) {
    TempUser.username = username;
  }

  static void setName({required String name}) {
    TempUser.name = name;
  }

  static void setImage({required String image}) {
    TempUser.image = image;
  }

  static void setId({required String id}) {
    TempUser.id = id;
  }

  static void userSetData(context) async {
    //  print(email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('id');
    String? token = prefs.getString('token');
    setToken(token: token!);
    dynamic result = await Api.getwithToken(
        token: token,
        url: '${baseURL}users/$userid');
    if (result is String) {
    } else if (result is Response) {
      
      Response res = result;
      setId(id: userid!);
      setEmail(email: res.data['data']['user']['email']);
      setName(name: res.data['data']['user']['name']);
      setUserName(username: res.data['data']['user']['username']);
      setImage(
          image: res.data['data']['user']['avatar'] ?? 'b631858bdaafa77258b9ed2f7c689bdb.png');

      
      BlocProvider.of<TweetsUpdateCubit>(context).refresh();

    }
  }
}
