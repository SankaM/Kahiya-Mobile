import 'package:flutter/material.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final double width;

  final double height;

  MyCircularProgressIndicator({this.width = -1, this.height = -1});

  @override
  Widget build(BuildContext context) {
    var _width = width == -1 ?  MediaQuery.of(context).size.width : width;
    var _height = width == -1 ?  MediaQuery.of(context).size.height : height;

    return Container(
      width: _width,
      height: _height,
      color: Colors.transparent,
      margin: EdgeInsets.all(20),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
