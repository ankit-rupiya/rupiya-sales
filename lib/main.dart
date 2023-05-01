import 'package:aveo_api/aveo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:sales/app/modules/auth/bindings/auth_binding.dart';
import 'package:sales/constants/color_schemes.g.dart';
import 'package:sales/constants/enums.dart';
import 'package:sales/utils/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AveoApi.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await GetStorage.init();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Rupiya Sales",
      initialRoute: AppPages.INITIAL,
      initialBinding: AuthBinding(),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      getPages: AppPages.routes,
      builder: (context, child) => AveoApiWrapper(
        offlineColor: lightColorScheme.error,
        child: child!,
      ),
    );
  }
}
