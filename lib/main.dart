import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer_course/src/routes/app_pages.dart';

void main() {

  // WidgetsFlutterBinding.ensureInitialized()

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: []
    );
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
