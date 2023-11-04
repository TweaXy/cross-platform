import 'dart:html';

import 'package:dio/dio.dart';

class SignInServices {
  String baseUrl = 'http://localhost:3000/api/v1';
  final Dio dio;
  SignInServices(this.dio);
  Future<String> forgetPasswordEmail({required String email}) async {
    print(email);
    Response? response;
    // Binary data
    try {
      response = await dio.request(
        '$baseUrl/auth/forgetPassword',
        data: {'UUID': email},
        options: Options(method: 'POST'),
      );

      return 'success';
    } on DioException catch (e) {
      int? res = e.response?.statusCode;
      final String errorMessage =
          e.response?.data['error']['message'] ?? res == 403
              ? "email or phone or username is required field"
              : res == 404
                  ? "User not found"
                  : res == 429
                      ? "More than one request in less than 30 seconds"
                      : "oops there is an error, try again later";
      return errorMessage;
      // if (res == 403)
      //   return "email or phone or username is required field";
      // else if (res == 404)
      //   return "User not found";
      // else if (res == 429)
      //   return "More than one request in less than 30 seconds";
      // else
      //   return "oops there is an error, try again later";
    } catch (e) {
      return "oops there is an error, try again later";
    }
  }
}
