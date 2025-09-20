import 'ppoint.dart';

class Segment {
  final PPoint<double> a;
  final PPoint<double> b;
  final int color;
  final int order;

  const Segment(this.a, this.b, this.color, this.order);

  factory Segment.fromMap(Map<String, dynamic> map) {
    return Segment(
      PPoint.fromMap(map['a']!),
      PPoint.fromMap(map['b']!),
      map['color'],
      map['order'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'a': a.toMap(),
      'b': b.toMap(),
      'color': color,
      'order': order,
    };
  }

  Segment copyWith({
    PPoint<double>? a,
    PPoint<double>? b,
    bool? wasDrawn,
    int? color,
    int? order,
  }) {
    return Segment(
      a ?? this.a,
      b ?? this.b,
      color ?? this.color,
      order ?? this.order,
    );
  }

  @override
  String toString() => '[$a, $b]';
}
