import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../entity/ppoint.dart';
import '../entity/segment.dart';
import 'control_button_widget.dart';
import 'input_point_widget.dart';

class SegmentFormWidget extends StatefulWidget {
  const SegmentFormWidget({super.key});

  @override
  State<SegmentFormWidget> createState() => _SegmentFormWidgetState();
}

class _SegmentFormWidgetState extends State<SegmentFormWidget> {
  static final axController = TextEditingController();
  static final ayController = TextEditingController();
  static final bxController = TextEditingController();
  static final byController = TextEditingController();

  bool _isValid() {
    return (
      axController.text.isNotEmpty &&
      ayController.text.isNotEmpty &&
      bxController.text.isNotEmpty &&
      byController.text.isNotEmpty
    );
  }

  void _addSegment() {
    if (!_isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xFF770000),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.endToStart,
        width: 300,
        content: Text(
          'Informe todas as coordenadas',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,),
        ), 
      ));
      return;
    }

    final ax = double.parse(axController.text);
    final ay = double.parse(ayController.text);
    final bx = double.parse(bxController.text);
    final by = double.parse(byController.text);
    final color = context.read<HomeBloc>().state.imageEntity.color;
    final order = context.read<HomeBloc>().state.order;
    final segment = Segment(PPoint(ax, ay), PPoint(bx, by), color, order);
    context.read<HomeBloc>().addSegment(segment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputPointWidget(
                    pointId: 'A',
                    xController: axController,
                    yController: ayController,
                  ),
                  InputPointWidget(
                    pointId: 'B',
                    xController: bxController,
                    yController: byController,
                  ),
                ],
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (p, c) => p.loading != c.loading,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ControlButtonWidget(
                    onPressed: state.loading ? null : _addSegment,
                    iconData: Icons.play_arrow_rounded,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
