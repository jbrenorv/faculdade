import 'package:flutter/material.dart';

class ControlButtonWidget extends StatelessWidget {
  const ControlButtonWidget({
    super.key,
    required this.iconData,
    this.onPressed,
    this.tooltipMessage,
  });

  final IconData iconData;
  final VoidCallback? onPressed;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    if (tooltipMessage != null) {
      return Tooltip(
        message: tooltipMessage,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Icon(iconData),
        ),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      child: Icon(iconData),
    );
  }
}
