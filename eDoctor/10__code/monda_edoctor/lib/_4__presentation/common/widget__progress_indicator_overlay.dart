import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

class ProgressIndicatorOverlay extends StatelessWidget {
  final String text;

  ProgressIndicatorOverlay({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      child: Center(
        child: Container(
            width: 150,
            height: 150,
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 5.0,),
                ),
                SizedBox(height: 25,),
                Text(text, style: TextStyle(color: Colors.white, fontSize: Style.fontSize_Default),),
              ],
            )
        ),
      ),
    );
  }
}
