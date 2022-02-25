import 'package:estacionamento/storage/data_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OcupationPageController extends GetxController {
  var lista = [].obs;

  var dbHelper = BancoDeDados.instance;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    List result = await dbHelper.getVagas('select * from $parkTable');
    lista.assignAll(result);
    update();
  }

  Future updateVaga(int preenchida, int vaga, int index,
      {entrada, saida}) async {
    await dbHelper.updateVagas({
      vacancyFilled: preenchida,
      dateOpen: entrada,
      dateOut: saida,
    }, vaga);
    fetchData();
  }

  String formatarData(DateTime data) {
    var dateFormatter = DateFormat('dd/MM/yyyy');
    var dataFormatada = dateFormatter.format(data);
    return dataFormatada;
  }
}
