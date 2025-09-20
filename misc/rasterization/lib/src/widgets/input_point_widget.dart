import 'package:flutter/material.dart';

import 'input_coordinate_widget.dart';

class InputPointWidget extends StatelessWidget {
  const InputPointWidget({
    super.key,
    required this.pointId,
    this.xController,
    this.yController,
  });

  final String pointId;
  final TextEditingController? xController;
  final TextEditingController? yController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          child: Text(pointId),
        ),
        const SizedBox(width: 4.0),
        InputCoordinateWidget(controller: xController),
        InputCoordinateWidget(hintText: 'y', controller: yController),
      ],
    );
  }
}
