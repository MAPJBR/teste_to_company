import 'package:estacionamento/controllers/report_controller.dart';
import 'package:estacionamento/storage/data_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[200],
          title: const Text('Historico de vagas'),
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
                      const Text('Permanece na vaga',
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
                      const Text('Liberado',
                          style: TextStyle(
                            fontSize: 15,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            GetBuilder(
              init: ReportPageController(),
              builder: (ReportPageController controller) => Expanded(
                  child: ListView.builder(
                      itemCount: controller.lista.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            shape: Border(
                                right: BorderSide(
                                    color: controller.lista[index]
                                                [historicDateOut] ==
                                            null
                                        ? Colors.red
                                        : Colors.green,
                                    width: 15)),
                            elevation: 4,
                            child: Column(
                              children: [
                                Text(
                                  'Vaga: ${controller.lista[index][historicParkingSpace]}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Cliente: ${controller.lista[index][costumerHistoric]}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Data de Entrada: ${controller.lista[index][historicDateOpen] ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Data de Saida: ${controller.lista[index][historicDateOut] ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  controller.lista[index][historicDateOut] ==
                                          null
                                      ? 'Situação: Permanece na vaga'
                                      : 'Situação: Liberado',
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            )
          ],
        ));
  }
}
