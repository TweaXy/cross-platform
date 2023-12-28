import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

void main() {
dynamic getMessages(String id, String token) async {
   
    return await Api.getwithToken(
        url: '${baseURL}conversations/$id?limit=10&offset=0', token: "token");
  }

  group('Test get messages api', () {
    test('Test1: get messages  ', () async {
      dynamic res= await  getMessages("", "");
      expect(
      res,
           "token not valid");
    });
    test('Test2: get messages  ', () async {
      expect(
         await getMessages("1235mmm45", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYTQ0bzlsem9qbGtybnZscmxhZDQ4dW1jN1wiIiwiaWF0IjoxNzAzNzEwMjQ1LCJleHAiOjE3MDYzMDIyNDV9.Noydn7vKZgYFyOXhiFtylQiIXLWWAbi2RVyRWzrVSKg"),
          "token not valid");
    });
     test('Test2: get messages  ', () async {
      expect(
         await getMessages("","bnZscmxhZDQ4dW1jN1wiIiwiaWF0IjoxNzAzNzEwMjQ1LCJleHAiOjE3MDYzMDIyNDV9.Noydn7vKZgYFyOXhiFtylQiIXLWWAbi2RVyRWzrVSKg"),
          "token not valid");
    });
  });
}
