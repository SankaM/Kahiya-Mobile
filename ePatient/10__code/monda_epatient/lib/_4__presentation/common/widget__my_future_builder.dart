import 'package:flutter/material.dart';
import 'package:monda_epatient/_4__presentation/common/widget__my_circular_progress_indicator.dart';

class MyFutureBuilder extends StatelessWidget {
  final Future future;

  final Function(AsyncSnapshot snapshot) widgetOnReady;

  MyFutureBuilder({required this.future, required this.widgetOnReady});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MyCircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
          return Center(child: Text('Something error'),);
        } else {
          return widgetOnReady(snapshot);
        }
      },
    );
  }
}
