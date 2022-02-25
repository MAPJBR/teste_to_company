import 'package:estacionamento/routes/routes.dart';
import 'package:estacionamento/storage/data_helper.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var lista = [].obs;

  var dbHelper = BancoDeDados.instance;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    List result = await dbHelper.getVagas('select * from $estacionamentoTable');
    lista.assignAll(result);
    print('Lista===>$lista');
  }

  Future getVagas() async {
    List result = await dbHelper.getVagas('select * from $estacionamentoTable');
    if (result.isEmpty) {
      for (var i = 1; i < 11; i++) {
        await dbHelper.insertVagas({vagaPreenchida: 0});
      }
    }
  }

  Future updateVaga(int preenchida, int vaga, int index,
      {entrada, saida}) async {
    await dbHelper.updateVagas({
      vagaPreenchida: preenchida,
      dataEntrada: entrada,
      dataSaida: saida,
    }, vaga);
    fetchData();
  }

  Future<dynamic> vagasPage() async {
    await getVagas();
    Get.toNamed(Routes.OCUPATION);
  }

  Future<dynamic> relatoriosPage() async {
    Get.toNamed(Routes.REPORT);
  }
}
