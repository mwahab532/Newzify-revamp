import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/core/theme/app_dimens.dart';
import 'package:mynewsapp/features/auth/login/login_controller.dart';
import 'package:mynewsapp/shared/widgets/inputs/auth_text_field.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
            vertical: AppDimens.spaceL,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: AppDimens.topSpacing,
              ),

              /// Title
              const Text(
                "Welcome Back!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: AppDimens.spaceS,
              ),

              /// Subtitle
              const Text(
                "Sign in to discover today's top headlines and stories tailored just for you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: AppDimens.spaceXXL,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        /// Email
                        AuthTextField(
                          controller: controller.emailController,
                          prefixIcon: const Icon(Icons.email_outlined),
                          lableText: "Email",
                          hintText: "Enter your email",
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Email can't be Empty";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: AppDimens.spaceL,
                        ),

                        /// Password
                        Obx(
                          () => AuthTextField(
                            controller: controller.passwordController,
                            prefixIcon: const Icon(Icons.lock_outline),
                            lableText: "Password",
                            hintText: "Enter your password",
                            isObscure:
                                !controller.isPasswordVisible.value,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Password can't be Empty";
                              }
                              if (text.length < 6) {
                                return "Password is wrong";
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: controller
                                  .togglePasswordVisibility,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: AppDimens.spaceXL,
                        ),

                        /// Login Button
                        SizedBox(
                          width: double.infinity,
                          height: AppDimens.buttonHeight,
                          child: RoundedLoadingButton(
                            controller:
                                controller.loginBtnController,
                            color: Colors.red,
                            successColor: Colors.green,
                            onPressed: controller.login,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: AppDimens.spaceXL,
                        ),

                        /// Divider
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.spaceM,
                              ),
                              child: Text(
                                "OR login with",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: AppDimens.spaceL,
                        ),

                        /// Google Login
                        GestureDetector(
                          onTap: controller.signInWithGoogle,
                          child: SizedBox(
                            height: AppDimens.socialIconSize,
                            width: AppDimens.socialIconSize,
                            child: Image.asset(
                              "assets/google-logo.png",
                              filterQuality:
                                  FilterQuality.high,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: AppDimens.spaceM,
              ),

              /// Bottom Sign Up
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimens.spaceM,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                    ),
                    GestureDetector(
                      onTap: controller.goToRegister,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}