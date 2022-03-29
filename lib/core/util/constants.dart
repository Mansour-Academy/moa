import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/di/injection.dart';
import 'package:moa/core/network/local/cache_helper.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/util/translation.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';

import '../models/comment_model.dart';
import 'cubit/cubit.dart';

List<CommentModel>? commentsListData;

List<CommentModel>? favListData;

List<CommentModel>? disFavListData;

int selectedService = 0;
int selectedCategory = 0;
bool isEnglish = true;

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

const String mainColor = 'ADD8E6';
const String secondary = '303C47';
const String secondaryVariant = '6A6D78';

const String darkGreyColor = '989898';
const String regularGrey = 'E9E8E7';
const String liteGreyColor = 'F9F8F7';

const String greenColor = '07B055';
const String blueColor = '0E72ED';

const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

String getTranslatedText({
  required String en,
  required String ar,
  required BuildContext context,
}) {
  if (AppCubit.get(context).isRtl) {
    return ar;
  }
  return en;
}

void signOut(context) {
  sl<CacheHelper>().clear('token').then((value) {
    if (value) {
      token = null;
      // showToast(
      //     message: 'Sign out Successfully', toastStates: ToastStates.SUCCESS);
      navigateAndFinish(context, const LoginPage());
    }
  });
}

Future<void> showLogoutDialog({
  required BuildContext context,
  required Function function,
}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: whiteColor),
        padding: EdgeInsets.all(
          responsiveValue(
            context,
            16.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appTranslation(context).logoutConfirmation,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            space20Vertical(context),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                      color: Theme.of(context).primaryColor.withOpacity(
                        .1,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: MaterialButton(
                      color: HexColor(liteGreyColor),
                      height: 52.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        appTranslation(context).cancel,
                        style: Theme.of(context).textTheme.button!.copyWith(
                          color: HexColor(secondaryVariant),
                        ),
                      ),
                    ),
                  ),
                ),
                space8Horizontal(context),
                Expanded(
                  child: MyButton(
                    onPressed: () {
                      function();
                    },
                    text: appTranslation(context).yes,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// void showToast({
//   required String message,
//   required ToastStates toastStates,
// }) =>
//     toast.Fluttertoast.showToast(
//         msg: message,
//         toastLength: toast.Toast.LENGTH_SHORT,
//         gravity: toast.ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 5,
//         backgroundColor: choseToastColor(toastStates),
//         textColor: Colors.white,
//         fontSize: 16.0);
//
// // ignore: constant_identifier_names
// enum ToastStates { SUCCESS, ERROR, WARNING }

TranslationModel appTranslation(context) =>
    AppCubit.get(context).translationModel;

double pxToDp(double pixel) => pixel * 1.2;

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget myDivider(context) => Divider(
      height: 1.0,
      color: HexColor(regularGrey),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void debugPrintFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: HexColor(regularGrey),
    );
  }
}

double responsiveValue(BuildContext context, double value) =>
    MediaQuery.of(context).size.width * (value / 375.0);

space3Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 3.0),
    );

space4Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 4.0),
    );

space5Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 5.0),
    );

space8Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 8.0),
    );

space10Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 10.0),
    );

space16Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 16.0),
    );

space20Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 20.0),
    );

space30Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 30.0),
    );

space40Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 40.0),
    );

space50Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 50.0),
    );

space60Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 60.0),
    );

space70Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 70.0),
    );

space80Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 80.0),
    );

space90Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 90.0),
    );

space100Vertical(BuildContext context) => SizedBox(
      height: responsiveValue(context, 100.0),
    );

space3Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 3.0),
    );

space4Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 4.0),
    );

space5Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 5.0),
    );

space8Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 8.0),
    );

space10Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 10.0),
    );

space15Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 15.0),
    );

space20Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 20.0),
    );

space30Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 30.0),
    );

space40Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 40.0),
    );

space50Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 50.0),
    );

space60Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 60.0),
    );

space70Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 70.0),
    );

space80Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 80.0),
    );

space90Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 90.0),
    );

space100Horizontal(BuildContext context) => SizedBox(
      width: responsiveValue(context, 100.0),
    );
