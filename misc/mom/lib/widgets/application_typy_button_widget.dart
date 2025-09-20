import 'package:flutter/material.dart';

class ApplicationTypyButtonWidget extends StatelessWidget {
  const ApplicationTypyButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox.square(
        dimension: 200.0,
        child: Card(
          child: Center(
            child: Text(text.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
