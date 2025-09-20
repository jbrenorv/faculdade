import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.name, required this.child});

  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(name),
            ),
          ),
          Expanded(
            flex: 1,
            child: child,
          ),
        ],
      ),
    );
  }
}
