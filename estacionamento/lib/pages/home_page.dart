import 'package:estacionamento/controllers/home_page_controller.dart';
import 'package:estacionamento/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomePageController(),
        builder: (HomePageController controller) => Scaffold(
                body: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              color: Colors.amber[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 22)),
                  Expanded(
                    child: Stack(
                      children: [
                        Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: const RiveAnimation.asset(
                                      'assets/boy_n_tree.riv'),
                                ),
                                Expanded(
                                  child: GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                    ),
                                    children: [
                                      menu('assets/car-parking.png', 'Vagas',
                                          20, controller.vagasPage),
                                      menu(
                                          'assets/history.png',
                                          'Historico de Vagas',
                                          20,
                                          controller.relatoriosPage)
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
