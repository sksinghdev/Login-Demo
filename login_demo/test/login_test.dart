import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:login_demo/app/modules/login/controllers/login_controller.dart';
import 'package:login_demo/app/modules/login/views/login_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LoginController mockAuthController;
  late LoginView loginView;
  setUp(() {
    Get.testMode = true;
    mockAuthController = LoginController();
    loginView = new LoginView();
    Get.put<LoginController>(mockAuthController);
  });
  tearDown(() {
    Get.delete<LoginController>();
  });
  Widget buildTestableWidget(Widget widget) {
    return new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: widget));
  }

  group('Login Controller', () {
    test('Check controller function ', () async {
      var password =
          await mockAuthController.validatePasswordView('Santosh@1412');
      expect(password, null);
      var password2 = await mockAuthController.validatePasswordView('sam');
      expect(password2, 'Password must be of 8 characters');
      var password3 = await mockAuthController.validatePasswordView('Santosh@');
      expect(password3, 'Password should be like this Santosh@1234');
      var name = await mockAuthController.validateEMailView('Santosh');
      expect(name, 'Provide valid email');
      var name2 =
          await mockAuthController.validateEMailView('sksinghdev2@gmail.com');
      expect(name2, null);
      var name3 = await mockAuthController.validateEMailView('');
      expect(name3, '');
      await mockAuthController.updatePasswordView();
      await mockAuthController.navigateToHomeView();
      await mockAuthController.navigateToRegisterView();
    });
    testWidgets('Find Ui widgets', (tester) async {
      await tester.pumpWidget(buildTestableWidget(loginView));
      expect(find.text('User Login '), findsOneWidget);
      await tester.fling(find.byType(Form), Offset(0, -200), 3000);
      await tester.pumpAndSettle();
    });
  });
}
