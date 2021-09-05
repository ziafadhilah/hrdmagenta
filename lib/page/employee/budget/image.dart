import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/api_clien.dart';

import 'package:photo_view/photo_view.dart';

class ImageTransaction extends StatefulWidget {
  ImageTransaction({this.image,this.title});

  var image;
  var title;

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<ImageTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black87,
          child: Center(
            child: Hero(
              tag: "show_image",
              child: Container(
                  child: widget.image == "null"
                      ? PhotoView(
                      imageProvider: AssetImage(
                        "assets/absen1.jpeg",
                      ))
                      : PhotoView(
                      imageProvider: NetworkImage(
                        "${image_ur}/eo/transactions/${widget.image}",
                      )
                  )),
            ),
          ),
        ));
  }
}
