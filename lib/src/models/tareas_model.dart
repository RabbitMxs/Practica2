class TareasModel {
  int? id;
  String? nomTarea;
  String? dscTarea;
  String? fechaEntrega;
  int? entregada;

  //Map
  TareasModel(
      {this.id,
      this.nomTarea,
      this.dscTarea,
      this.fechaEntrega,
      this.entregada});

  //Map -> Object
  factory TareasModel.fromMap(Map<String, dynamic> map) {
    return TareasModel(
        id: map['id'],
        nomTarea: map['nomTarea'],
        dscTarea: map['dscTarea'],
        fechaEntrega: map['fechaEntrega'],
        entregada: map['entregada']);
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomTarea': nomTarea,
      'dscTarea': dscTarea,
      'fechaEntrega': fechaEntrega,
      'entregada': entregada
    };
  }
}
