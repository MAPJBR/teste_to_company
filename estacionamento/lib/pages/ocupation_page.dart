import 'package:estacionamento/controllers/ocupation_controller.dart';
import 'package:estacionamento/storage/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcupationPage extends StatelessWidget {
  OcupationPage({Key? key}) : super(key: key);
  var color = MaterialStateProperty.all(const Color(0xFFFFE0B2));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vagas Estacionamento'),
        backgroundColor: Colors.amber[200],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 10,
                      height: 10,
                    ),
                    const Text('Ocupado',
                        style: TextStyle(
                          fontSize: 15,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      color: Colors.green,
                      width: 10,
                      height: 10,
                    ),
                    const Text('Livre',
                        style: TextStyle(
                          fontSize: 15,
                        ))
                  ],
                ),
              ),
            ],
          ),
          GetBuilder(
              init: OcupationPageController(),
              builder: (OcupationPageController controller) => Expanded(
                  child: ListView.builder(
                      itemCount: controller.lista.length,
                      itemBuilder: (context, index) {
                        Map<String, String> cliente = {'RESULTADO': ''};

                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Card(
                            shape: Border(
                                right: BorderSide(
                                    color: controller.lista[index]
                                                [vacancyFilled] ==
                                            0
                                        ? Colors.green
                                        : Colors.red,
                                    width: 15)),
                            elevation: 4,
                            child: Column(
                              children: [
                                Text(
                                    """Data de Entrada: ${controller.lista[index][dateOpen] ?? ''}    Data de Saída: ${controller.lista[index][dateOut] ?? ''}"""),
                                Text(
                                    'Vaga n° ${controller.lista[index][parkingSpace]}',
                                    style: const TextStyle(fontSize: 22)),
                                controller.lista[index][vacancyFilled] == 0
                                    ? const Text('Vaga Livre',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                    : const Text(
                                        'Vaga Ocupada',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        style:
                                            ButtonStyle(backgroundColor: color),
                                        onPressed: controller.lista[index]
                                                    [vacancyFilled] ==
                                                0
                                            ? () async {
                                                final TextEditingController
                                                    textController =
                                                    TextEditingController();
                                                var dataEntrada =
                                                    DateTime.now();
                                                var dataFormatada = controller
                                                    .formatarData(dataEntrada);
                                                cliente =
                                                    await Get.defaultDialog(
                                                        title:
                                                            'Informe o Cliente',
                                                        content: TextField(
                                                          controller:
                                                              textController,
                                                        ),
                                                        actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back(result: {
                                                            'RESULTADO':
                                                                textController
                                                                    .text
                                                          });
                                                        },
                                                        child: const Text('Ok'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                            'Cancelar'),
                                                      )
                                                    ]);

                                                await controller.updateVaga(
                                                    1,
                                                    controller.lista[index]
                                                        [parkingSpace],
                                                    index,
                                                    entrada: dataFormatada);
                                                await controller.dbHelper
                                                    .insertHistorico({
                                                  historicParkingSpace:
                                                      controller.lista[index]
                                                          [parkingSpace],
                                                  costumerHistoric:
                                                      cliente['RESULTADO'],
                                                  historicDateOpen:
                                                      dataFormatada
                                                });
                                              }
                                            : null,
                                        child: const Text('Entrada')),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    ElevatedButton(
                                        style:
                                            ButtonStyle(backgroundColor: color),
                                        onPressed: controller.lista[index]
                                                    [vacancyFilled] ==
                                                1
                                            ? () async {
                                                var resultHistorico =
                                                    await controller.dbHelper
                                                        .getIdHistorico(
                                                            controller.lista[
                                                                    index]
                                                                [parkingSpace]);
                                                var dataSaida = DateTime.now();
                                                var dataFormatada = controller
                                                    .formatarData(dataSaida);
                                                await controller.updateVaga(
                                                    0,
                                                    controller.lista[index]
                                                        [parkingSpace],
                                                    index,
                                                    saida: dataFormatada);
                                                await controller.dbHelper
                                                    .updateHistorico({
                                                  historicDateOut:
                                                      dataFormatada,
                                                }, resultHistorico[idHistoric]);
                                              }
                                            : null,
                                        child: const Text('Saída'))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })))
        ],
      ),
    );
  }
}
