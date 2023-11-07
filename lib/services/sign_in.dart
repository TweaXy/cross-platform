import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/api.dart';

class SignInServices {
  String baseUrl = kIsWeb
      ? 'http://localhost:3000/api/v1'
      : 'http://192.168.1.31:3000/api/v1';
  // String baseUrl = 'http://localhost:3000/api/v1';

  final Dio dio;
  SignInServices(this.dio);

  dynamic forgetPasswordEmail({required String email}) async {
    print(email);
    var res = await Api.post(
      body: {'UUID': email},
      url: '$baseUrl/auth/forgetPassword',
    );
    print('signin' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }
}
