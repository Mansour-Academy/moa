import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';

class StartItem extends StatelessWidget {
  const StartItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.image,
  }) : super(key: key);
  final String text;
  final String image;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.zero,
          color: HexColor(liteGreyColor),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/$image.png'),
                        color: HexColor(mainColor),
                      ),
                      // child: SvgPicture.asset(
                      //   'assets/images/$image.svg',
                      //   color: HexColor(mainColor),
                      //   height: double.infinity,
                      // ),
                    ),
                    space16Vertical(context),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: HexColor(mainColor),
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
