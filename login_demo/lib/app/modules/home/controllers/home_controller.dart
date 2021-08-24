import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_demo/app/routes/app_pages.dart';
import 'package:login_demo/app/utils/validator.dart';

class HomeController extends GetxController with ValidationMixin {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  late TextEditingController emailController,
      passwordController,
      nameController,
      mobileController;
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  final hidePassword = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    nameController = new TextEditingController();
    emailController = new TextEditingController();
    mobileController = new TextEditingController();
    passwordController = new TextEditingController();
    getInfoFromDb();
  }

  getInfoFromDb() {
    nameController.text = box.read('name');
    emailController.text = box.read('email');
    passwordController.text = box.read('password');
    String mobileNumber = box.read('mobile');
    print('mobileNumber $mobileNumber');
    if (mobileNumber.contains('+91- ')) {
      mobileNumber = mobileNumber.replaceAll('+91- ', '');
      mobileController.text = mobileNumber;
    } else {
      mobileController.text = box.read('mobile');
    }
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

  logOutUser() {
    box.erase();
    Get.snackbar("Alert", "You have successfully Logout");
    Future.delayed(Duration(seconds: 2))
        .whenComplete(() => Get.offAllNamed(Routes.LOGIN));
  }

  updateUserInfo() {
    final isValid = profileFormKey.currentState!.validate();
    if (!isValid) {
      Get.snackbar("Error", "Please check input fields");
      return;
    } else {
      box.write('name', nameController.text);
      box.write('email', emailController.text);
      box.write('mobile', '+91- ' + mobileController.text);
      box.write('password', passwordController.text);
      Get.snackbar("Alert", "User update successfully");
    }
    profileFormKey.currentState!.save();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }
}
