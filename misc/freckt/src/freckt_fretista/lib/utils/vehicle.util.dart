class Vehicle {
  String placa;
  String uf;
  String renavam;
  String ano;
  String marca;
  String cor;
  String tipo;
  String capacidade;

  Vehicle({
    this.placa,
    this.uf,
    this.renavam,
    this.ano,
    this.marca,
    this.cor,
    this.tipo,
    this.capacidade,
  });

  //Vehicle.fromJson(Map<String, dynamic> json) {
  //  placa = json['placa'];
  //  uf = json['uf'];
  //  renavam = json['renavam'];
  //  ano = json['ano'];
  //  marca = json['marca'];
  //  cor = json['cor'];
  //  tipo = json['tipo'];
  //  capacidade = json['capacidade'];
  //}

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placa'] = this.placa;
    data['uf'] = this.uf;
    data['renavam'] = this.renavam;
    data['ano'] = this.ano;
    data['marca'] = this.marca;
    data['cor'] = this.cor;
    data['tipo'] = this.tipo;
    data['capacidade'] = this.capacidade;
    return data;
  }
}
