import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sajilo_dokan/bindings/main_binding.dart';
import 'package:sajilo_dokan/presentation/pages/Category/categories_binding.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category_products.dart';
import 'package:sajilo_dokan/presentation/pages/cart/cart_screen.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_binding.dart';
import 'package:sajilo_dokan/presentation/pages/details/product_details_screen.dart';

import 'package:sajilo_dokan/presentation/pages/home/home_screen.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/home_binding.dart';
import 'package:sajilo_dokan/presentation/pages/landing_home/landing_home.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_binding.dart';
import 'package:sajilo_dokan/presentation/pages/login/login_screen.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splace_screen.dart';
import 'package:sajilo_dokan/presentation/pages/splash/splash_binding.dart';

class SajiloDokanRoutes {
  static final String splash = '/splash';
  static final String home = '/home';
  static final String login = '/login';
  static final String landingHome = '/landingHome';
  static final String productDetails = '/productDetails';
  static final String cart = '/cart';
  static final String categoryProduct = '/categoryProduct';
}

class SajiloDokanPages {
  static final pages = [
    GetPage(
        name: SajiloDokanRoutes.splash,
        page: () => SplashScreen(),
        binding:
            SplashBinding()), //  yasle garda suru maa Yo controller  initiaze hunxa
    GetPage(name: SajiloDokanRoutes.home, page: () => Home()),
    GetPage(
        name: SajiloDokanRoutes.login,
        page: () => LoginScreen(),
        bindings: [LoginBinding(), MainBinding()],
        binding: LoginBinding()),
    GetPage(
        name: SajiloDokanRoutes.landingHome,
        page: () => LandingHome(),
        binding: HomeBinding(),
        bindings: [MainBinding(), HomeBinding(), CategoriesBinding()]),
    GetPage(
        name: SajiloDokanRoutes.productDetails,
        page: () => ProductDetailsScreen(),
        bindings: [ProductDetailsBinding(), MainBinding()]),
    GetPage(
        name: SajiloDokanRoutes.cart,
        page: () => CartScreen(0),
        bindings: [MainBinding()]),
    GetPage(
        name: SajiloDokanRoutes.categoryProduct,
        page: () => CategoryProducts(),
        bindings: [MainBinding(), CategoriesBinding()])
  ];
}
