import 'package:estacionamento/bidings/home_page_binding.dart';
import 'package:estacionamento/pages/home_page.dart';
import 'package:estacionamento/pages/ocupation_page.dart';
import 'package:estacionamento/pages/report_page.dart';
import 'package:estacionamento/routes/routes.dart';
import 'package:get/get.dart';

class AppPage {
  static final routes = [
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        binding: HomePageBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.REPORT,
        page: () => ReportPage(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.OCUPATION,
        page: () => OcupationPage(),
        transition: Transition.downToUp),
  ];
}
