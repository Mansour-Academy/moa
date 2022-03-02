import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';

import '../widgets/my_requests_widget.dart';

class MyRequestsPage extends StatelessWidget {
  const MyRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      scaffold: Scaffold(
        body: SafeArea(
          child: HideKeyboardPage(
            child: MyRequestsWidget(),
          ),
        ),
      ),
    );
  }
}
