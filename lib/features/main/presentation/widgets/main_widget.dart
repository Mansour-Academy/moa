import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/network/remote/api_endpoints.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/my_form.dart';
import 'package:moa/core/util/widgets/my_indicator.dart';
import 'package:moa/features/register/presentation/pages/register_page.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  // http://agri-egypt.it-blocks.com:82/
  // http://agri-egypt.it-blocks.com:82/

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'http://agri-egypt.it-blocks.com:82/Account/LoginMobile?token=$token'),
                  method: 'POST',
                ),
                onLoadStop: (value, uri) {
                  debugPrint('stop');
                  debugPrint(value.javaScriptHandlersMap.toString());
                  debugPrint(uri.toString());
                  debugPrint(uri!.path);

                  AppCubit.get(context).changeLoad(
                    load: true,
                  );

                  if(uri.path == '/Home/SignOut') {
                    signOut(context);
                  }
                },
                // onLoadStart: (value, uri) {
                //   debugPrint('created');
                //   debugPrint(value.javaScriptHandlersMap.toString());
                //   debugPrint(uri.toString());
                //   debugPrint(uri!.path);
                //
                //   AppCubit.get(context).changeLoad(
                //     load: true,
                //   );
                // },
                onWebViewCreated: (value) {
                  debugPrint('loading');

                  AppCubit.get(context).changeLoad(
                    load: false,
                  );
                },
              ),
              if (!AppCubit.get(context).isLoaded) const MyIndicator(),
            ],
          ),
        );
      },
    );
  }
}
