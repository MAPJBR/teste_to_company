import 'package:get/get.dart';
import '../storage/data_helper.dart';

class ReportPageController extends GetxController {
  var lista = [].obs;

  var dbHelper = BancoDeDados.instance;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    List result = await dbHelper.getHistorico();
    lista.assignAll(result);
    update();
  }
}
