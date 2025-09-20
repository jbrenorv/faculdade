import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freckt_cliente/utils/consts.dart';

class AvatarTemplate extends StatelessWidget {
  final String url;

  AvatarTemplate({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          child: CircularProgressIndicator(
            strokeWidth: 1.0,
            valueColor: AlwaysStoppedAnimation<Color>(Consts.greenDark),
          ),
          width: 50.0,
          height: 50.0,
          padding: EdgeInsets.all(15.0),
        ),
        imageUrl: url,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      clipBehavior: Clip.hardEdge,
    );
  }
}
