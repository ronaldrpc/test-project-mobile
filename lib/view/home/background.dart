import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  final String? title;
  final double? height;

  GradientBack({Key? key, this.title, required this.height});

  @override
  Widget build(BuildContext context) {
    //variable para obtener la altura de cualquier pantalla de un celular
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    double? _height;

    //Establecemos si la altura del gradiente es fullscreeen o alguna medida en particular
    if (height == null) {
      _height = screenHeight;
    } else
      _height = height;

    return Container(
      width: screenWidht,
      height: _height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'))),
    );
  }
}
