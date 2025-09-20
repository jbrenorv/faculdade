class Resolution {
  final int width;
  final int height;

  const Resolution(this.width, this.height);

  @override
  String toString() => '${width}x$height';

  @override
  bool operator ==(Object other) {
    return other is Resolution && other.width == width && other.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;

  /// [width, height]
  List<int> get toList => [width, height];

  factory Resolution.fromMap(Map<String, int> map) {
    return Resolution(map['width']!, map['height']!);
  }

  Map<String, int> toMap() {
    return {
      'width': width,
      'height': height,
    };
  }
}
