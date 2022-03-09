import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/keep_alive_widget.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';

import '../widgets/my_requests_widget.dart';

class MyRequestsPage extends StatelessWidget {
  const MyRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWidget(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appTranslation(context).myRequests,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const SafeArea(
          child: HideKeyboardPage(
            child: MyRequestsWidget(),
          ),
        ),
      ),
    );
  }
}
