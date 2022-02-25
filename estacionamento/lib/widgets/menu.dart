import 'package:flutter/material.dart';

@override
Widget menu(String image, String text, double size, var function) {
  return GestureDetector(
    onTap: function,
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(image: AssetImage(image), scale: 6),
            color: Colors.amber[300],
          ),
          height: 170,
          width: 170,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
