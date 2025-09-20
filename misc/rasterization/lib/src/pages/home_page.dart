import 'package:flutter/material.dart';

import '../widgets/form_wrapper_widget.dart';
import '../widgets/image_control_widget.dart';
import '../widgets/image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const FormWrapperWidget(),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Column(
                children: const [
                  Expanded(child: ImageWidget()),
                  SizedBox(height: 8),
                  ImageControlWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
