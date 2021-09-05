import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/api_clien.dart';

import 'package:photo_view/photo_view.dart';

class ImageFile extends StatefulWidget {
  ImageFile({this.image});

  var image;


  @override
  _ImageFileState createState() => _ImageFileState();
}

class _ImageFileState extends State<ImageFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black87,
          child: Center(
            child: Hero(
              tag: "show_image_file",
              child: Container(
                  child: widget.image == "null"
                      ? PhotoView(

                          imageProvider: AssetImage(

                          "assets/defaul1t.jpeg",
                        ))
                      : PhotoView(
                          imageProvider: FileImage(widget.image)
                  )
              ),
            ),
          ),
        ));
  }
}
