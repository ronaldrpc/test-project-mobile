class Service {
  // Those properties shoud be boolean xd
  String? lavado;
  String? polish;
  String? tapiceria;

  Service({this.lavado, this.polish, this.tapiceria});

  Service.fromJson(Map<String, dynamic> json) {
    lavado = json['lavado'];
    polish = json['polish'];
    tapiceria = json['tapiceria'];
  }

  @override
  String toString() {
    return "\nLavado: $lavado \nPolish: $polish \nTapiceria: $tapiceria";
  }
}