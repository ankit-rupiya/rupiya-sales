import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/constants/assets.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          Assets.assetsLaunchImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
