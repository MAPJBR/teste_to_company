import 'package:estacionamento/bidings/home_page_binding.dart';
import 'package:estacionamento/routes/pages.dart';
import 'package:estacionamento/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Estacionamento do seu ze',
      initialRoute: Routes.HOME,
      getPages: AppPage.routes,
      initialBinding: HomePageBinding(),
    );
  }
}
