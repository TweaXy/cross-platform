
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/sign_in.dart';

void main() {
  group('Test Reset Password Api', () {
    test('Test1: Reset Password for Non-existing email test', () async {
      SignInServices.setEmail(email: "m@gmail.com");
      SignInServices.setToken(token: 'hhh12345');
      expect(await SignInServices.resetPassword('Mm12345!'), "User not found");
    });
    test('Test2: Reset Password for Existing email but with wrong token format test',
        () async {
      SignInServices.setEmail(email: "mennaahmed0701@gmail.com");
      SignInServices.setToken(token: 'hhhh');
      expect(await SignInServices.resetPassword('12345'),
          "reset password code must be 8 characters");
    });
    test('Test3: Reset Password for Existing email but with wrong password test',
        () async {
      SignInServices.setEmail(email: "mennaahmed0701@gmail.com");
      SignInServices.setToken(token: 'hhh12345');
      expect(await SignInServices.resetPassword('12345'),
          "password must contain 8 or more characters with at least one of each: uppercase, lowercase, number and special");
    });
    test(
        'Test4: Reset Password for Existing email but with valid password and wrong token test',
        () async {
      SignInServices.setEmail(email: "Derek_Baumbach");
      SignInServices.setToken(token: 'hhh12345');
      expect(await SignInServices.resetPassword('Mm12345!'),
          "User does not have reset token");
    });
  });
}
