import 'ppoint.dart';

class Polygon {
  final List<PPoint<double>> vertices;
  final int color;
  final int order;

  const Polygon(this.vertices, this.color, this.order);

  factory Polygon.fromMap(Map<String, dynamic> map) {
    return Polygon(
      (map['vertices'] as List).map((e) => PPoint<double>.fromMap(e)).toList(),
      map['color'],
      map['order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vertices': vertices.map((e) => e.toMap()).toList(),
      'color': color,
      'order': order,
    };
  }

  Polygon copyWith({
    List<PPoint<double>>? vertices,
    bool? wasDrawn,
    int? color,
    int? order,
  }) {
    return Polygon(
      vertices ?? this.vertices,
      color ?? this.color,
      order ?? this.order,
    );
  }

  @override
  String toString() => vertices.toString();
}
