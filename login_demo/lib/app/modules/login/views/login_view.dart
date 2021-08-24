import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  Text(
                    "User Login ",
                    style: TextStyle(fontSize: 20,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailController,

                    validator: (value) {
                      return controller.validateEMailView(value!);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() => TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Obx(() => IconButton(
                                  icon: Icon(
                                    controller.hidePassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,

                                  ),
                                  onPressed: () {
                                    controller.updatePasswordView();
                                  },
                                ))),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.hidePassword.value,
                        controller: controller.passwordController,

                        validator: (value) {
                          return controller.validatePasswordView(value!);
                        },
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurpleAccent),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        controller.checkLogin();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('You do not have account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, )),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      controller.navigateToRegisterView();
                    },
                    child: Text('Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
