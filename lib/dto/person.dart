import 'package:flutter_application_1/dto/car.dart';
import 'package:flutter_application_1/dto/service.dart';

class Person {
  String? nombre;
  String? apellido;
  String? licencia;
  int? cel;
  Car? carro;
  Service? servicio;

  Person({this.nombre, this.apellido, this.licencia, this.cel, this.carro, this.servicio});

  Person.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellido = json['apellido'];
    licencia = json['licencia'];
    cel = json['cel'];
    carro = Car.fromJson(json['Carro']);
    servicio = Service.fromJson(json['Servicio']);
  }

  @override
  String toString() {
    return "Nombre: $nombre \nApellido: $apellido \nLicencia: $licencia \nCel: $cel \n\nCarro: $carro \n\nServicio: $servicio";
  }
}