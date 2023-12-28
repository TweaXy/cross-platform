
import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/suggestions_search.dart';

void main() {
  group('test Suggestions search', () {
    test('Test1: suggesfully get sugesstions', () async {
      dynamic response=SuggestionsSearch(Dio()).getSuggesstion("a",0);
      print(response);
      expect(response,response.statusCode==200);
    });
  
  });
}
