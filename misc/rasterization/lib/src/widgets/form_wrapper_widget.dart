import 'dart:math';

import 'package:flutter/material.dart';

import 'polygon_form_widget.dart';
import 'segment_form_widget.dart';
import 'settings_widget.dart';

class FormWrapperWidget extends StatefulWidget {
  const FormWrapperWidget({super.key});

  @override
  State<FormWrapperWidget> createState() => _FormWrapperWidgetState();
}

class _FormWrapperWidgetState extends State<FormWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final formWidth = min(400.0, deviceWidth * 1 / 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: formWidth,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.amber,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                  tabs: <Widget>[
                    _buildTab('Seguimento', Icons.remove),
                    _buildTab('Polígono', Icons.pentagon_outlined),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SegmentFormWidget(),
                      PolygonFormWidget(),
                    ],
                  ),
                ),
                if (constraints.maxHeight > 400) const SettingsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(String text, IconData iconData) {
    return Tab(
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}
