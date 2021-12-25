import 'package:get/get.dart';
import 'package:sajilo_dokan/domain/repository/api_repository.dart';
import 'package:sajilo_dokan/domain/repository/local_repository.dart';
import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SplashController(
      {required this.localRepositoryInterface, required this.apiRepositoryInterface});

  @override
  void onReady() {
    validateSession();
    super.onReady();
  }

  void validateSession() async {
    final token = await localRepositoryInterface.getToken();
    if (token != null) {
      final result = await apiRepositoryInterface.getUserFromToken(token);
      if (result != null) {
        await localRepositoryInterface.saveUser(result.user);
        Get.offNamed(SajiloDokanRoutes.landingHome);
      } else {
        Get.offNamed(SajiloDokanRoutes.landingHome);
      }
    } else
      Get.offNamed(SajiloDokanRoutes.landingHome);
  }
}
