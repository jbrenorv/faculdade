import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:freckt_cliente/utils/consts.dart';

class FullPhoto extends StatelessWidget {
  final String url;

  FullPhoto({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Consts.greenAppBar,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FullPhotoScreen(url: url),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String url;

  FullPhotoScreen({Key key, @required this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState(url: url);
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  final String url;

  FullPhotoScreenState({Key key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(imageProvider: CachedNetworkImageProvider(url)));
  }
}
