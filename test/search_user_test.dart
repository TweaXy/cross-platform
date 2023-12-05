import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/search_for_users.dart';

void main() {
  group('Search User Test', () {
    test('Search with as', () async {
      var list = await SearchForUsers.searchForUser('as',
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiZmRkd29ubTNyamthOG5oMGxtaGM0cjRiclwiIiwiaWF0IjoxNzAxNzgxMDc2LCJleHAiOjE3MDQzNzMwNzZ9.2_bbSU3EoEBCCGeoIfq4urLvQQiOs2bgDtpu96z01nA');
      var testList = [
        User(
          id: 'clps6plbd0006b4rvyx6knju0',
          userName: 'sgglnashed_87759323',
          name: 'eman',
          avatar: 'uploads/default.png',
        ),
      ];
      expect(list, testList);
    });
    test('Not Found User', () async {
      var list = await SearchForUsers.searchForUser('awaw',
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiZmRkd29ubTNyamthOG5oMGxtaGM0cjRiclwiIiwiaWF0IjoxNzAxNzgxMDc2LCJleHAiOjE3MDQzNzMwNzZ9.2_bbSU3EoEBCCGeoIfq4urLvQQiOs2bgDtpu96z01nA');
      var testList = [];
      expect(list, testList);
    });
  });
}
