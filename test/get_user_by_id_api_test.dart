import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/get_user_by_id.dart';

void main() async {
  User user1 =
      await GetUserById.instance.getUserById('clpe7z04p0003pu0xnd75rqxo');
  group('GetUserById testing', () {
    test('Get Profile Data', () {
      User testUser = User(
        id: 'clpe7z04p0003pu0xnd75rqxo',
        userName: 'ahmedsamy',
        name: 'Ahmed Samy',
        email: 'nname1858@gmail.com',
        avatar: 'uploads/default.png',
        cover: null,
        phone: null,
        birthdayDate: '2002-08-27T00:00:00.000Z',
        joinedDate: '2023-11-25T15:42:01.321Z',
        bio: null,
        location: null,
        followers: 0,
        following: 0,
        website: null,
      );
      expect(
        user1,
        testUser,
      );
    });
  });
}
