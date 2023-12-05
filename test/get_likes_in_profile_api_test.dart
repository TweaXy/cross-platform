import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/services/get_likers_in_profile.dart';

void main() async {
  GetLikersInProfile service = GetLikersInProfile(Dio());

  group('GetUserById testing', () {
    test('Test1 : Get liked Tweet Successfuly', () async {
      expect(await service.likersList(pageNumber: 10), null);
    });
    test('Test2 : Wrong ID ', () async {
      expect(await service.likersList(pageNumber: 0), "no user found.");
    });

    test('Test3 : Send Wrong Paramenters ', () async {
      expect(await service.likersList(pageNumber: -1),
          "Invalid parameters provided");
    });
  });
}
