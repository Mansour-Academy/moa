import 'package:moa/core/util/widgets/my_cupertino_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

class MyIndicator extends StatelessWidget {
  const MyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyCupertinoActivityIndicator(
        activeColor: HexColor(mainColor),
      ),
    );
  }
}
