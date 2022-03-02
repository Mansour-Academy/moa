import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';

import '../widgets/main_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      scaffold: Scaffold(
        body: SafeArea(
          child: HideKeyboardPage(
            child: MainWidget(),
          ),
        ),
      ),
    );
  }
}
