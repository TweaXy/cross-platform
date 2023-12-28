import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/sign_in.dart';

void main() {
  group('Test Check Reset Token Api', () {

    print('\n');
    test('Test1: Check Reset Token for invalid email and token', () async {
      SignInServices.setEmail(email: 'k');
      SignInServices.setToken(token: 'k0000000');

      expect(await SignInServices.checkResetToken(),
          "must have email format");
    });
    print('\n');
     test('Test2: Check Reset Token for invalid email and token', () async {
      SignInServices.setEmail(email: 'k');
      SignInServices.setToken(token: 'k');

      expect(await SignInServices.checkResetToken(),
          "email verification code must be 8 characters");
    });
      test('Test3: Check Reset Token for invalid email and token', () async {
      SignInServices.setEmail(email: 'k@gmail.com');
      SignInServices.setToken(token: 'k0000000');

      expect(await SignInServices.checkResetToken(),
          "User not found");
    });
    
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
