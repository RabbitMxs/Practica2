class FavoritaModel {
  int? id;
  String? title;
  String? backdropPath;

  FavoritaModel({
    this.id,
    this.title,
    this.backdropPath,
  });

  factory FavoritaModel.fromMap(Map<String, dynamic> map) {
    return FavoritaModel(
      id: map['id'],
      title: map['title'],
      backdropPath: map['backdrop_path'] ?? '',
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
    };
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.title} }';
  }
}
