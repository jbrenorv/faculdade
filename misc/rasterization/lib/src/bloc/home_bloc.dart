import 'package:bloc/bloc.dart';

import '../entity/polygon.dart';
import '../entity/image_entity.dart';
import '../entity/resolution.dart';
import '../entity/segment.dart';
import '../utils/rasterization_util.dart';

class HomeState {
  final bool loading;
  final ImageEntity imageEntity;
  final int currentNumberOfVertices;
  final int order;
  final bool saveData;

  HomeState({
    this.loading = true,
    this.imageEntity = const ImageEntity(),
    this.currentNumberOfVertices = 3,
    this.order = 0,
    this.saveData = false,
  });
}

class HomeBloc extends Cubit<HomeState> {
  final RasterizationUtil rasterizer = RasterizationUtil();

  HomeBloc() : super(HomeState());


  void changeResolution(Resolution resolution) {
    final imageEntity = state.imageEntity.copyWith(resolution: resolution);
    _updateState(loading: true, imageEntity: imageEntity);
  }


  void changeColor(int color) {
    final imageEntity = state.imageEntity.copyWith(color: color);
    _updateState(imageEntity: imageEntity);
  }


  void changeLoading(bool loading) {
    final imageEntity = state.imageEntity.copyWith(
      segments: state.imageEntity.segments.map((s) => s.copyWith(wasDrawn: true)).toList(),
    );
    _updateState(loading: loading, imageEntity: imageEntity);
  }


  void addSegment(Segment segment) {
    final imageEntity = state.imageEntity.copyWith(
      segments: [...state.imageEntity.segments, segment]
    );
    _updateState(loading: true, imageEntity: imageEntity, order: state.order + 1);
  }


  void clear() {
    final imageEntity = state.imageEntity.copyWith(
      segments: [],
      polygons: [],
    );
    _updateState(loading: true, imageEntity: imageEntity);
  }


  void addVertex() {
    int cur = state.currentNumberOfVertices;
    _updateState(currentNumberOfVertices: cur + 1);
  }


  void removeVertex() {
    int cur = state.currentNumberOfVertices;
    _updateState(currentNumberOfVertices: cur - 1);
  }


  void addPolygon(Polygon polygon) {
    final imageEntity = state.imageEntity.copyWith(
      polygons: [...state.imageEntity.polygons, polygon]
    );
    _updateState(loading: true, imageEntity: imageEntity, order: state.order + 1);
  }

  void saveData() => _updateState(saveData: true);

  void _updateState({
    bool? loading,
    ImageEntity? imageEntity,
    int? currentNumberOfVertices,
    int? order,
    bool? saveData,
  }) {
    emit(HomeState(
      loading: loading ?? state.loading,
      imageEntity: imageEntity ?? state.imageEntity,
      currentNumberOfVertices: currentNumberOfVertices ?? state.currentNumberOfVertices,
      order: order ?? state.order,
      saveData: saveData ?? false,
    ));
  }
}
