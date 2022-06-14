class Car {
  String? color;
  String? marca;
  int? modelo;
  String? placa;

  Car({this.color, this.marca, this.modelo, this.placa});

  Car.fromJson(Map<String, dynamic> json) {
    color = json['Color'];
    marca = json['marca'];
    modelo = json['modelo'];
    placa = json['placa'];
  }

  @override
  String toString() {
    return "\nColor: $color \nMarca: $marca \nModelo: $modelo \nPlaca: $placa";
  }

  Map<String, dynamic> toJson() {
    return {
      "Color": color,
      "marca": marca,
      "modelo": modelo,
      "placa": placa,
    };
  }
}