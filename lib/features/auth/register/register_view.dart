import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:mynewsapp/features/auth/register/register_controller.dart';
import 'package:mynewsapp/shared/widgets/inputs/auth_text_field.dart';

/// Was views/Auth_View_screens/Register.dart.
class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset("assets/Newszify.png", height: 120, fit: BoxFit.contain),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Please create an account to get started.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 305,
                  child: AuthTextField(
                    controller: controller.usernameController,
                    hintText: "Enter username",
                    validator: (text) => text!.isEmpty ? "Username should not be Empty" : null,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  width: 305,
                  child: TextFormField(
                    controller: controller.emailController,
                    validator: (text) => text!.isEmpty ? "Email can't be empty" : null,
                    decoration: InputDecoration(
                      suffixIcon: Obx(() => TextButton(
                            onPressed: controller.isSendingOtp.value ? null : controller.sendOtp,
                            child: Text(controller.isSendingOtp.value ? "Sending..." : "Send OTP"),
                          )),
                      border: const OutlineInputBorder(),
                      hintText: "email@example.com",
                    ),
                  ),
                ),
              ),
              Obx(() => AuthTextField(
                    controller: controller.passwordController,
                    hintText: "Password",
                    isObscure: !controller.isPasswordVisible.value,
                    validator: (text) {
                      if (text!.isEmpty) return "Password can't be empty";
                      if (text.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                          controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedLoadingButton(
                  controller: controller.registerBtnController,
                  color: Colors.red,
                  successColor: Colors.green,
                  onPressed: controller.register,
                  child: const Text("Next", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
