import 'package:flutter_application_1/entities/car.dart';
import 'package:flutter_application_1/entities/service.dart';

class Record {
  String? id;
  String? nombre;
  String? apellido;
  String? licencia;
  int? cel;
  Car? carro;
  Service? servicio;

  Record({this.nombre, this.apellido, this.licencia, this.cel, this.carro, this.servicio});

  Record.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellido": apellido,
      "cell": cel,
      "licencia": licencia,
      "Carro": (carro != null) ? carro!.toJson() 
      : Car().toJson(),
      "Servicio": (servicio != null) ? servicio!.toJson() 
      : Service(lavado: "no", polish: "no",  tapiceria: "no").toJson(),
    };
  }
}