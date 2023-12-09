import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/services/update_password_service.dart';

void main() async {
  UpdatePasswordService service = UpdatePasswordService(Dio());

  group('GetUserById testing', () {
    test('Test1 : Update password Successfuly', () async {
      final response = await service.updatePassword(
        oldPassword: '12345678tT@',
        newPassword: '12345678yY@',
        confirmPassword: '12345678yY@',
      );
      expect(response, null);
    });
    test('Test2 : Update password with unmatching new / confirm password',
        () async {
      expect(
          await service.updatePassword(
              oldPassword: '12345678yY@',
              newPassword: '12345678tT@',
              confirmPassword: '12345677tT@'),
          'new password does not match with confirm password');
    });

    test('Test3: Update password with invalid new password', () async {
      expect(
          await service.updatePassword(
              oldPassword: '12345678yY@',
              newPassword: '12345678tT',
              confirmPassword: '12345677tT'),
          'password must contain at least 1 special character');
    });
  });
}
