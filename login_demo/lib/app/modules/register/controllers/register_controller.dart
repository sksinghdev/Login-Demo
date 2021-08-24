import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_demo/app/routes/app_pages.dart';
import 'package:login_demo/app/utils/validator.dart';

class RegisterController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      mobileController,
      passwordController;
  final hidePassword = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    mobileController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  void updatePasswordView() {
     hidePassword.value = !hidePassword.value;
   }

  String? validateMobileView(String value) {
    return value.length <= 0 ? '' : validateMobile(value);
  }

  String? validateEmailView(String value) {
    return value.length <= 0 ? '' : validateEmail(value);
  }

  String? validateNameView(String value) {
    return value.length <= 0 ? '' : validateName(value);
  }

  String? validatePasswordView(String value) {
    return value.length <= 0 ? '' : validatePassword(value);
  }

  void checkRegister() {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      String? userEmail = box.read('email');
      if (userEmail == emailController.text) {
        Get.snackbar("Alert", "Email already exists");
      } else {
        box.write('name', nameController.text);
        box.write('email', emailController.text);
        box.write('mobile', '+91- '+mobileController.text);
        box.write('password', passwordController.text);
        Get.snackbar("Alert", "User register successfully");
        box.write('home', true);
      }
    }
    registerFormKey.currentState!.save();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
