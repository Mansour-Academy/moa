import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moa/core/di/injection.dart' as di;
import 'package:moa/core/di/injection.dart';
import 'package:moa/core/util/bloc_observer.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';
import 'package:moa/features/my_requests/presentation/pages/my_requests_page.dart';

import 'core/network/local/cache_helper.dart';
import 'core/network/remote/api_endpoints.dart';
import 'core/util/constants.dart';
import 'features/start/presentation/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isRtl = true;

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  token = await sl<CacheHelper>().get('token');

  debugPrintFullText('My Current Token => $token');

  runApp(MyApp(
    token: token,
    isRtl: isRtl,
    translation: translation,
  ));
}

class MyApp extends StatelessWidget {
  String? token;
  final bool isRtl;
  final String translation;

  MyApp({
    Key? key,
    required this.token,
    required this.isRtl,
    required this.translation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppCubit>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            ),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'MOA',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppCubit.get(context).lightTheme,
            home: token != null ? const StartPage() : const LoginPage(),
          );
        },
      ),
    );
  }
}
