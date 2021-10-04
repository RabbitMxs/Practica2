class PerfilModel {
  int? id;
  String? avatar;
  String? nombre;
  String? apellidoP;
  String? apellidoM;
  String? tel;
  String? email;

  PerfilModel(
      {this.id,
      this.avatar,
      this.nombre,
      this.apellidoP,
      this.apellidoM,
      this.tel,
      this.email});

  factory PerfilModel.fromMap(Map<String, dynamic> map) {
    return PerfilModel(
        id: map['id'],
        avatar: map['avatar'],
        nombre: map['nombre'],
        apellidoP: map['apellidoP'],
        apellidoM: map['apellidoM'],
        tel: map['tel'],
        email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar': avatar,
      'nombre': nombre,
      'apellidoP': apellidoP,
      'apellidoM': apellidoM,
      'tel': tel,
      'email': email
    };
  }
}
