import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/features/splash/splash_controller.dart';

/// Was views/splashsrceen.dart.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Get.find<SplashController>();
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _worker = ever<bool>(controller.showNoInternetDialog, (show) {
      if (show) _showNoInternetDialog(context);
    });
  }

  @override
  void dispose() {
    _worker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset("assets/Newszify.png", height: 120, fit: BoxFit.contain),
            ),
            const SizedBox(height: 50),
            const Text(
              "Instantly get world Top news",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 50),
            Obx(() => controller.showSpinner.value
                ? const CircularProgressIndicator()
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('No Internet'),
        content: const Text('Please check your connection'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.retry();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
