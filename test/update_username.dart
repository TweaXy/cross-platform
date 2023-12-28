import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/services/update_username_service.dart';

void main() async {
  UpdateUsernameService service = UpdateUsernameService(Dio());
  String token = '';

  group('Update Username testing', () {
    test('Test1 : Update username Successfuly', () async {
      final response = await service.updateUsername(token, 'Yarraa');
      expect(response, null);
    });
    test('Test2 : Update username with invalid length username', () async {
      expect(await service.updateUsername(token, 'Ya'),
          'username must be at least 4 characters');
    });

    test('Test3: Update username with invalid username', () async {
      expect(await service.updateUsername(token, 'Yarraa'),
          'username already exists.');
    });
  });
}
