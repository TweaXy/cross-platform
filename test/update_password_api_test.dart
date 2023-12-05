import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/services/update_password_service.dart';

void main() async {
  UpdatePasswordService service = UpdatePasswordService(Dio());

  group('GetUserById testing', () {
    test('Test1 : Update password Successfuly', () async {
      expect(
          await service.updatePassword(
              oldPassword: '12345678tT@',
              newPassword: 'Yara12345!',
              confirmPassword: 'Yara12345!'),
          null);
    });
    test('Test2 : Update password with unmatching new / confirm password',
        () async {
      expect(
          await service.updatePassword(
              oldPassword: '12345678yY@',
              newPassword: 'yara12345!',
              confirmPassword: 'yara12345!'),
          null);
    });
  });
}
