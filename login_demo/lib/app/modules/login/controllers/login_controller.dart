import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_demo/app/routes/app_pages.dart';
import 'package:login_demo/app/utils/validator.dart';

class LoginController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final hidePassword = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  updatePasswordView() {
    hidePassword.value = !hidePassword.value;
  }

  String? validateEMailView(String value) {
    return value.length <= 0 ? '' : validateEmail(value);
  }

  String? validatePasswordView(String value) {
    return value.length <= 0 ? '' : validatePassword(value);
  }

  checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      String? emailValue = box.read('email');
      String? passwordValue = box.read('password');

      if (emailValue == emailController.text &&
          passwordValue == passwordController.text) {
        box.write('home', true);
        navigateToHomeView();
      } else {
        Get.snackbar("Error", "Please check email or password");
      }
    }
    loginFormKey.currentState!.save();
  }

  navigateToRegisterView() {

  }

  navigateToHomeView() {

  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
