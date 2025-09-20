import 'package:image/image.dart';

import '../entity/image_entity.dart';
import 'rasterization_util.dart';

Color colorFromInt(int value) {
  final r = ((value & (255 << 16)) >> 16);
  final g = ((value & (255 <<  8)) >>  8);
  final b = ((value & (255 <<  0)) >>  0);
  return ColorInt32.rgb(r, g, b);
}

List<int> encodePNG(Map<String, dynamic> data) {
  final rasterizationUtil = RasterizationUtil();
  final imageEntity = ImageEntity.fromMap(data);
  final nObjects = imageEntity.nObjects;
  final nSegments = imageEntity.nSegments;
  final imageResult = Image(
    height: imageEntity.resolution.height,
    width: imageEntity.resolution.width
  );

  var segmentsCount = 0;
  var polygonsCount = 0;

  for (var i = 0; i < nObjects; ++i) {

    if (segmentsCount < nSegments && i == imageEntity.segments[segmentsCount].order) {
      
      final from = imageEntity
          .segments[segmentsCount]
          .a
          .getRescaledCoordinates(imageEntity.resolution);
      
      final to = imageEntity
          .segments[segmentsCount]
          .b
          .getRescaledCoordinates(imageEntity.resolution);
      
      rasterizationUtil.rasterizeSegment(
        image: imageResult,
        from: from,
        to: to,
        color: colorFromInt(imageEntity.segments[segmentsCount].color),
      );
      ++segmentsCount;
    }
    
    else {
      final polygonVertices = imageEntity
          .polygons[polygonsCount]
          .vertices
          .map((vertex) => vertex.getRescaledCoordinates(imageEntity.resolution))
          .toList();

      rasterizationUtil.rasterizePolygon(
        image: imageResult,
        vertices: polygonVertices,
        color: colorFromInt(imageEntity.polygons[polygonsCount].color),
      );
      ++polygonsCount;
    }
  }

  return encodePng(imageResult).toList();
}
