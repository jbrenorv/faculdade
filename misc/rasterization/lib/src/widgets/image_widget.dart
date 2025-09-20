import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../utils/save_data_util.dart';
import '../bloc/home_bloc.dart';
import '../utils/encode_image_util.dart';
import '../entity/image_entity.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  static Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    _updateImage(context.read<HomeBloc>().state.imageEntity);
  }

  Future<void> _updateImage(ImageEntity imageEntity) async {
    bytes = Uint8List.fromList((await compute(encodePNG, imageEntity.toMap())));
    return Future(() => context.read<HomeBloc>().changeLoading(false));
  }

  void _onHomeStateChange(BuildContext context, HomeState state) {
    if (state.saveData) {
      SaveDataUtil.saveData(bytes!, state.imageEntity.getModelContent());
      return;
    }

    _updateImage(state.imageEntity);
  }

  Widget _buildFromState(BuildContext context, HomeState state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Image.memory(
      bytes!,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: _onHomeStateChange,
      builder: _buildFromState,
      listenWhen: (previous, current) => (previous.loading != current.loading && current.loading) || current.saveData,
      buildWhen: (previous, current) => (previous.loading != current.loading),
    );
  }
}
