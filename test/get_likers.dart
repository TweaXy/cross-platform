import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/get_likers.dart';

void main() {
  Likers service = Likers();
  group('Test Trends Api', () {
    test('Test1: Return List of Followers', () async {
      expect(
          await service.getLikers(id: 'dasdasdasdas', pageSize: 5, offset: 0),
          isA<List<FollowersModel>>());
    });
    runTests();
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
