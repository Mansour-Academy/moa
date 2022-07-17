import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request(); // if you need microphone permission

  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isRtl = true;

  var s = {
    "to" : "/topics/DE_17",
    "notification": {
      "title": "notification title",
      "body": "notification body",
      "sound": "default"
    },
    "android": {
      "priority": "HIGH",
      "notification": {
        "notification_priority": "PRIORITY_MAX",
        "sound": "default",
        "default_sound": true,
        "default_vibrate_timings": true,
        "default_light_settings": true
      }
    },
    "data": {
      "id": "POST_ID",
      "click_action": "FLUTTER_NOTIFICATION_CLICK"
    }
  };

  debugPrintFullText(s.toString());

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  token = await sl<CacheHelper>().get('token');

  debugPrintFullText('My Current Token => $token');

  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.instance.getToken().then((value) {
    debugPrintFullText('My Current Token => $value');
  });

  FirebaseMessaging.instance.subscribeToTopic('DE_17');

  FirebaseMessaging.onMessage.listen((message) {
    debugPrintFullText('Message => $message');
  });

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

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
