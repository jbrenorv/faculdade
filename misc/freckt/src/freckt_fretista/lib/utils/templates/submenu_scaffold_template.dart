import 'package:flutter/material.dart';
import 'package:freckt_fretista/utils/consts.dart';

class SubmenuScaffoldTemplate extends StatelessWidget {
  const SubmenuScaffoldTemplate({
    Key key,
    @required this.body,
    @required this.title,
  }) : super(key: key);

  final Widget body;
  final String title;

  static const Color _black = Colors.black;
  static const Color _white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _white,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: TextStyle(color: _black),
        ),
      ),
      body: Padding(padding: EdgeInsets.all(10.0), child: body),
    );
  }
}
