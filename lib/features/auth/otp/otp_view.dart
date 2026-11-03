import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/features/auth/otp/otp_controller.dart';
import 'package:mynewsapp/shared/widgets/inputs/auth_text_field.dart';

/// Was views/otpverification.dart.
class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset("assets/Newszify.png", height: 120, fit: BoxFit.contain),
              ),
            ),
            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.red),
            ),
            const Text(
              "Please Enter the OTP sent to your email",
              style: TextStyle(fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AuthTextField(
                controller: controller.otpController,
                hintText: "Enter OTP",
                keyboardType: TextInputType.number,
                validator: (text) => text!.isEmpty ? "OTP can't be empty" : null,
              ),
            ),
            Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: controller.isVerifying.value ? null : controller.verifyOtp,
                  child: Text(controller.isVerifying.value ? 'Verifying...' : 'Verify OTP'),
                )),
          ],
        ),
      ),
    );
  }
}
