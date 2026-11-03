import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/auth/auth_gate.dart';
import 'package:mynewsapp/features/app_shell/app_shell_binding.dart';
import 'package:mynewsapp/features/app_shell/app_shell_view.dart';
import 'package:mynewsapp/features/auth/login/login_binding.dart';
import 'package:mynewsapp/features/auth/login/login_view.dart';
import 'package:mynewsapp/features/auth/otp/otp_binding.dart';
import 'package:mynewsapp/features/auth/otp/otp_view.dart';
import 'package:mynewsapp/features/auth/register/register_binding.dart';
import 'package:mynewsapp/features/auth/register/register_view.dart';
import 'package:mynewsapp/features/favorites/favorites_binding.dart';
import 'package:mynewsapp/features/favorites/favorites_view.dart';
import 'package:mynewsapp/features/news_detail/news_detail_binding.dart';
import 'package:mynewsapp/features/news_detail/news_detail_view.dart';
import 'package:mynewsapp/features/splash/splash_binding.dart';
import 'package:mynewsapp/features/splash/splash_view.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: AppRoutes.authGate, page: () => const AuthGate()),
    GetPage(name: AppRoutes.login, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: AppRoutes.register, page: () => const RegisterView(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.otp, page: () => const OtpView(), binding: OtpBinding()),
    GetPage(name: AppRoutes.home, page: () => const AppShellView(), binding: AppShellBinding()),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
  ];
}
