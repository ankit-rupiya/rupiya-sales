import 'package:get/get.dart';

import '../modules/add_customer_form/bindings/add_customer_form_binding.dart';
import '../modules/add_customer_form/views/add_customer_form_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/insights/bindings/insights_binding.dart';
import '../modules/insights/views/insights_view.dart';
import '../modules/map_track/bindings/map_track_binding.dart';
import '../modules/map_track/views/map_track_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CUSTOMER_FORM,
      page: () => const AddCustomerFormView(),
      binding: AddCustomerFormBinding(),
    ),
    GetPage(
      name: _Paths.INSIGHTS,
      page: () => const InsightsView(),
      binding: InsightsBinding(),
    ),
    GetPage(
      name: _Paths.MAP_TRACK,
      page: () => const MapTrackView(),
      binding: MapTrackBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
