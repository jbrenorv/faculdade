import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../entity/polygon.dart';
import '../entity/polygon_vertex_form_entity.dart';
import '../entity/ppoint.dart';
import 'control_button_widget.dart';
import 'input_point_widget.dart';

const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
final List<PolygonVertexFormEntity> inputVertices = List.generate(
  26,
  (i) => PolygonVertexFormEntity(
    alphabet[i],
    TextEditingController(),
    TextEditingController(),
  ),
);

class PolygonFormWidget extends StatefulWidget {
  const PolygonFormWidget({super.key});

  @override
  State<PolygonFormWidget> createState() => _PolygonFormWidgetState();
}

class _PolygonFormWidgetState extends State<PolygonFormWidget> {
  final _scrollCtrl = ScrollController();  

  bool _isValid(int nVertices) {
    bool result = true;
    for (var i = 0; i < nVertices; ++i) {
      result &= (
        inputVertices[i].xController.text.isNotEmpty &&
        inputVertices[i].yController.text.isNotEmpty
      );
    }
    return result;
  }

  void _addPolygon(int nVertices) {
    if (!_isValid(nVertices)) {
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

    int color = context.read<HomeBloc>().state.imageEntity.color;
    int order = context.read<HomeBloc>().state.order;
    final vertices = <PPoint<double>>[];
    for (var i = 0; i < nVertices; ++i) {
      double x = double.parse(inputVertices[i].xController.text);
      double y = double.parse(inputVertices[i].yController.text);
      vertices.add(PPoint(x, y));
    }
    context.read<HomeBloc>().addPolygon(Polygon(vertices, color, order));
  }

  void _addVertex() {
    context.read<HomeBloc>().addVertex();
    Future.delayed(
      const Duration(milliseconds: 200),
      () => _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent),
    );
  }

  void _removeVertex() {
    context.read<HomeBloc>().removeVertex();
  }

  Widget _buildFromState(BuildContext context, HomeState state) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          Expanded(
            child: Center(
              child: ListView.builder(
                controller: _scrollCtrl,
                itemCount: state.currentNumberOfVertices,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InputPointWidget(
                    pointId: inputVertices[index].name,
                    xController: inputVertices[index].xController,
                    yController: inputVertices[index].yController,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ControlButtonWidget(
                  onPressed: state.currentNumberOfVertices < 26 ? _addVertex : null,
                  iconData: Icons.add_rounded,
                ),
                ControlButtonWidget(
                  onPressed: state.currentNumberOfVertices > 3 ? _removeVertex : null,
                  iconData: Icons.remove_rounded,
                ),
                ControlButtonWidget(
                  onPressed: state.loading
                      ? null
                      : () => _addPolygon(state.currentNumberOfVertices),
                  iconData: Icons.play_arrow_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: _buildFromState,
      buildWhen: (p, c) => p.currentNumberOfVertices != c.currentNumberOfVertices,
    );
  }
}
