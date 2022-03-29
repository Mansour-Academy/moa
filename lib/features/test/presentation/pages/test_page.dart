import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/widgets/hide_keyboard_page.dart';
import 'package:moa/core/util/widgets/main_scaffold.dart';
import 'package:moa/features/login/presentation/widgets/login_widget.dart';
import 'package:moa/features/test/presentation/pages/search_page.dart';

import '../../../../core/util/cubit/state.dart';
import '../widgets/test_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();

    AppCubit.get(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: const Text(
            'Company',
          ),
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, const SearchPage(),);
              },
              icon: const Icon(
                FontAwesomeIcons.search,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18.0,
              ),
              child: Container(
                width: 1.5,
                color: whiteColor,
              ),
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    AppCubit.get(context).changeLanguage();
                  },
                  child: Image.asset('assets/images/${AppCubit.get(context).isRtl ? 'tran-e1' : 'tran'}.png',),
                  // icon: Center(
                  //   child: Text(
                  //     AppCubit
                  //         .get(context)
                  //         .isRtl ? 'E' : 'ع',
                  //     style: GoogleFonts.lato(
                  //       color: whiteColor,
                  //       fontSize: AppCubit
                  //           .get(context)
                  //           .isRtl ? 22.0 : 24.0,
                  //         //fontStyle: FontStyle.italic,
                  //       fontWeight: AppCubit
                  //           .get(context)
                  //           .isRtl ? FontWeight.w400 : FontWeight.w700,
                  //       height: AppCubit
                  //           .get(context)
                  //           .isRtl ? 1.1 : 1.0,
                  //     ),
                  //   ),
                  // ),
                );
              },
            ),
          ],
        ),
        body: const SafeArea(
          child: HideKeyboardPage(
            child: TestWidget(),
          ),
        ),
      ),
    );
  }
}
