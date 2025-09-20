import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  final Color pickerColor;
  final void Function(Color) onColorChanged;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
              content: SingleChildScrollView(
                child: SlidePicker(
                  pickerColor: widget.pickerColor,
                  onColorChanged: widget.onColorChanged,
                  colorModel: ColorModel.rgb,
                  enableAlpha: false,
                  indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(backgroundColor: widget.pickerColor),
      child: Text(
        'Selecione',
        style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
      ),
    );
  }
}
