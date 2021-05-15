import 'package:flutter/material.dart';
import 'package:monda_epatient/_0__infra/asset.dart';

class MondaLogo extends StatelessWidget {
  final double width;

  MondaLogo({required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Asset.png__logo,
      width: width,
    );
  }
}
