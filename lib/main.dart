import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/bindings/main_binding.dart';
import 'package:sajilo_dokan/config/theme.dart';

import 'package:sajilo_dokan/presentation/routes/sajilodokan_navigation.dart';

void main() {
  runApp(SajiloDokanApp());
}

class SajiloDokanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SajiloTheme.of(context),
      initialRoute: SajiloDokanRoutes.splash,
      getPages: SajiloDokanPages.pages,
      initialBinding: MainBinding(),
    );
  }
}
