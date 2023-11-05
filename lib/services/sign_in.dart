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
    // Response? response;
    // Binary data
    // try {
    //   response = await dio.post(
    //     '$baseUrl/auth/forgetPassword',
    //     data: {'UUID': email},
    //   );
    //   print(response.data);
    //   return 'success';
    // } on DioException catch (e) {
    //   print(response);
    //   // var res = e.response!;
    //   // print(res.extra);
    //   // print("mmmmmm=" + res.extra['message'].toString());
    //   // final String errorMessage =
    //   //     e.response?.data['error']['message'] ?? res == 403
    //   //         ? "email or phone or username is required field"
    //   //         : res == 404
    //   //             ? "User not found"
    //   //             : res == 429
    //   //                 ? "More than one request in less than 30 seconds"
    //   //                 : "oops there is an error, try again later";
    //   return e.response!.statusMessage!;
    //   // if (res == 403)
    //   //   return "email or phone or username is required field";
    //   // else if (res == 404)
    //   //   return "User not found";
    //   // else if (res == 429)
    //   //   return "More than one request in less than 30 seconds";
    //   // else
    //   //   return "oops there is an error, try again later";
    // } catch (e) {
    //   return "oops there is an error, try again later";
    // }
  }
}
