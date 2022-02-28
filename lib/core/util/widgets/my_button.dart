import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/my_cupertino_indicator.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  double width;
  bool isLoading;

  MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        color: Theme.of(context).primaryColor,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        height: 52.0,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.button,
            ),
            if (isLoading) space10Horizontal(context),
            if (isLoading) const MyCupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
