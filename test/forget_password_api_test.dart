
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/sign_in.dart';

void main() {
  group('Test forget Password Api', () {
    test('Test1: Forget Password for Existing email Test', () async {
      SignInServices.setEmail(email: "mennaahmed0701@gmail.com");
      expect(await SignInServices.forgetPassword(), "success");
    });
    print('\n');
    test('Test2: Too much forget password requests Test', () async {
      SignInServices.setEmail(email: "mennaahmed0701@gmail.com");
      expect(await SignInServices.forgetPassword(),
          "More than one request in less than 30 seconds");
    });
    print('\n');
    runTests();

    test('Test3: Forget Password for Non Existing email Test', () async {
      SignInServices.setEmail(email: "mennaahm@gm.com");
      expect(await SignInServices.forgetPassword(), "User not found");
    });
    runTests();
    print('\n');
    test('Test4: Forget Password for no input email test even the button won\'t be enabled', () async {
      SignInServices.setEmail(email: "");
      expect(await SignInServices.forgetPassword(),
          "email or phone or username is required field");
    });
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
