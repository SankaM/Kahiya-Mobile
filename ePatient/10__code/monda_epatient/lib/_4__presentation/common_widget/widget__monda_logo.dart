import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/asset.dart';

class MondaLogo extends StatelessWidget {
  final double sideLength;

  MondaLogo({required this.sideLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideLength,
      height: sideLength,
      child: Image.asset(
        Asset.png__logo,
        width: sideLength,
      ),
    );
  }
}
