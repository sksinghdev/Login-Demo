import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 1,
        title: new Text(
          "Edit Profile",
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 500), () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.power_settings_new_sharp,
            ),
            onPressed: () {
              controller.logOutUser();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Form(
                key: controller.profileFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Name",
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.name,
                      controller: controller.nameController,
                      onSaved: (value) {
                        // controller.name = value!;
                      },
                      validator: (value) {
                        return controller.validateNameView(value!);
                      },
                    ),
                    SizedBox(
                      height: 16,
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
                      onSaved: (value) {
                        // controller.email = value!;
                      },
                      validator: (value) {
                        return controller.validateEmailView(value!);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Mobile Number",
                        prefixIcon: Container(
                          width: 100,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.phone_android),
                              Text(
                                " +91- ",
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller: controller.mobileController,
                      validator: (value) {
                        return controller.validateMobileView(value!);
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
                      constraints:
                          BoxConstraints.tightFor(width: context.width),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.deepPurpleAccent),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(14)),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          controller.updateUserInfo();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
