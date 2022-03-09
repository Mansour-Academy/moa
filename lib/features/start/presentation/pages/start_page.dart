import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/features/main/presentation/pages/main_page.dart';
import 'package:moa/features/my_requests/presentation/pages/my_requests_page.dart';

import '../widgets/start_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        body: PageView(
          controller: AppCubit.get(context).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            MainPage(),
            MyRequestsPage(),
          ],
        ),
        bottomNavigationBar: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (int index) {
                AppCubit.get(context).bottomChanged(index, context);
              },
              elevation: 20.0,
              unselectedLabelStyle: TextStyle(
                color: HexColor(regularGrey),
                height: 1.7,
              ),
              selectedLabelStyle: const TextStyle(
                height: 1.7,
              ),
              currentIndex: AppCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: Icon(
                      Icons.home,
                    ),
                  ),
                  label: appTranslation(context).home,
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: Icon(
                      FontAwesomeIcons.th,
                    ),
                  ),
                  label: appTranslation(context).myRequests,
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: Icon(
                      Icons.logout,
                    ),
                  ),
                  label: appTranslation(context).logout,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
