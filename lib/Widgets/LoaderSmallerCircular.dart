import 'package:flutter/material.dart';

class LoaderSmallerCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      child:
          FittedBox(fit: BoxFit.scaleDown, child: CircularProgressIndicator()),
    );
  }
}
