import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCoordinateWidget extends StatelessWidget {
  const InputCoordinateWidget({
    super.key,
    this.hintText = 'x',
    this.controller,
  });

  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 75.0,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[-]?(\d+)?\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
