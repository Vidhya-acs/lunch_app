import 'package:get/get.dart';
import 'package:lunch_app/bookin/booking_binding.dart';
import 'package:lunch_app/bookin/booking_view.dart';
import 'package:lunch_app/fetch/fetch_binding.dart';
import 'package:lunch_app/fetch/fetch_view.dart';
import 'package:lunch_app/home/home_binding.dart';
import 'package:lunch_app/home/home_view.dart';
import 'package:lunch_app/login.dart/login_binding.dart';
import 'package:lunch_app/login.dart/login_view.dart';
import 'package:lunch_app/view_order/view_order_binding.dart';
import 'package:lunch_app/view_order/view_order_page.dart';
import '../splash/splash_binding.dart';
import '../splash/splash_view.dart';
import 'app_path.dart';

class RoutesOfPages {
  static const initial = AppPath.splash;
  // static String initialLoginRoute = '/';
  // static String getLoginRoute() => initialLoginRoute;

  static List<GetPage> routes = [
    GetPage(
        name: AppPath.splash,
        page: () => SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: AppPath.login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: AppPath.home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
        name: AppPath.booking,
        page: () => LunchBookingView(),
        binding: BookingBinding()),
    //  GetPage(
    //       name: AppPath.fetchview,
    //       page: () => FetchView(),
    //       binding: FetchBinding()),
    GetPage(
        name: AppPath.viewOder,
        page: () => ViewOrder(),
        binding: ViewOrderBinding())
  ];
}
