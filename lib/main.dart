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
import 'package:moa/features/test/presentation/pages/test_page.dart';

import 'core/models/comment_model.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/api_endpoints.dart';
import 'core/util/constants.dart';
import 'features/start/presentation/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FirebaseOptions options = FirebaseOptions.fromMap(const {
  //   'projectId':'taxi-app-335615',
  //   'apiKey':'AAAALGle8qI:APA91bH2kvrm9BTVONdWwWrl0DJuMTaq_cYRsOCpSdUr06nSbYRdjA1MoUnlmJ5OjEz6hCs461atypTr4mn5HbzRNI5UEdqBKC-v4716Cb3wz3_GtFz9zyuBv5gOkSyVe2UqTUpqfHYb',
  //   'appId':'1:190746391202:android:44c0edc28e3ccda9269dfb',
  //   'messagingSenderId':'190746391202',
  // });

  await Firebase.initializeApp(
    // options: options,
    // name: 'New App',
  );

  Bloc.observer = MyBlocObserver();

  await di.init();

  bool isRtl = false;

  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('trl ------------- $value');
    if (value != null) {
      isRtl = value;

      isEnglish = !isRtl;
    } else {
      isEnglish = !isRtl;
    }
  });

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  token = await sl<CacheHelper>().get('token');

  debugPrintFullText('My Current Token => $token');

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // FirebaseMessaging.instance.getToken().then((value) => debugPrint(value));

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.instance.subscribeToTopic('posts');

  // sl<CacheHelper>().clear('comments');
  // sl<CacheHelper>().clear('fav');

  sl<CacheHelper>().get('comments').then((value) {
    print('comments ---------------------------- $value');

    if(value != null) {
      commentsListData = MainCommentModel.fromJson(value).data;

    }
  });

  sl<CacheHelper>().get('fav').then((value) {
    print('fav ---------------------------- $value');

    if(value != null) {
      favListData = MainCommentModel.fromJson(value).data;
    }
  });

  sl<CacheHelper>().get('disFav').then((value) {
    print('disFav ---------------------------- $value');

    if(value != null) {
      disFavListData = MainCommentModel.fromJson(value).data;
    }
  });

  String t2 = 'بِسْمِ اللَِّهِ الرَّحْمَٰنِ الرَّحِيمِ محمد';
  String t3 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

  String nt2 = normalise(t2);
  String nt3 = normalise(t3);

  print(nt2.contains(RegExp(r'[\u0600-\u06FF]'))); // prints "true"

  runApp(MyApp(
    token: token,
    isRtl: isRtl,
    translation: translation,
  ));
}

String normalise(String input) => input
    .replaceAll('\u0610', '') //ARABIC SIGN SALLALLAHOU ALAYHE WA SALLAM
    .replaceAll('\u0611', '') //ARABIC SIGN ALAYHE ASSALLAM
    .replaceAll('\u0612', '') //ARABIC SIGN RAHMATULLAH ALAYHE
    .replaceAll('\u0613', '') //ARABIC SIGN RADI ALLAHOU ANHU
    .replaceAll('\u0614', '') //ARABIC SIGN TAKHALLUS

//Remove koranic anotation
    .replaceAll('\u0615', '') //ARABIC SMALL HIGH TAH
    .replaceAll(
    '\u0616', '') //ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
    .replaceAll('\u0617', '') //ARABIC SMALL HIGH ZAIN
    .replaceAll('\u0618', '') //ARABIC SMALL FATHA
    .replaceAll('\u0619', '') //ARABIC SMALL DAMMA
    .replaceAll('\u061A', '') //ARABIC SMALL KASRA
    .replaceAll('\u06D6',
    '') //ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA
    .replaceAll('\u06D7',
    '') //ARABIC SMALL HIGH LIGATURE QAF WITH LAM WITH ALEF MAKSURA
    .replaceAll('\u06D8', '') //ARABIC SMALL HIGH MEEM INITIAL FORM
    .replaceAll('\u06D9', '') //ARABIC SMALL HIGH LAM ALEF
    .replaceAll('\u06DA', '') //ARABIC SMALL HIGH JEEM
    .replaceAll('\u06DB', '') //ARABIC SMALL HIGH THREE DOTS
    .replaceAll('\u06DC', '') //ARABIC SMALL HIGH SEEN
    .replaceAll('\u06DD', '') //ARABIC END OF AYAH
    .replaceAll('\u06DE', '') //ARABIC START OF RUB EL HIZB
    .replaceAll('\u06DF', '') //ARABIC SMALL HIGH ROUNDED ZERO
    .replaceAll('\u06E0', '') //ARABIC SMALL HIGH UPRIGHT RECTANGULAR ZERO
    .replaceAll('\u06E1', '') //ARABIC SMALL HIGH DOTLESS HEAD OF KHAH
    .replaceAll('\u06E2', '') //ARABIC SMALL HIGH MEEM ISOLATED FORM
    .replaceAll('\u06E3', '') //ARABIC SMALL LOW SEEN
    .replaceAll('\u06E4', '') //ARABIC SMALL HIGH MADDA
    .replaceAll('\u06E5', '') //ARABIC SMALL WAW
    .replaceAll('\u06E6', '') //ARABIC SMALL YEH
    .replaceAll('\u06E7', '') //ARABIC SMALL HIGH YEH
    .replaceAll('\u06E8', '') //ARABIC SMALL HIGH NOON
    .replaceAll('\u06E9', '') //ARABIC PLACE OF SAJDAH
    .replaceAll('\u06EA', '') //ARABIC EMPTY CENTRE LOW STOP
    .replaceAll('\u06EB', '') //ARABIC EMPTY CENTRE HIGH STOP
    .replaceAll('\u06EC', '') //ARABIC ROUNDED HIGH STOP WITH FILLED CENTRE
    .replaceAll('\u06ED', '') //ARABIC SMALL LOW MEEM

//Remove tatweel
    .replaceAll('\u0640', '')

//Remove tashkeel
    .replaceAll('\u064B', '') //ARABIC FATHATAN
    .replaceAll('\u064C', '') //ARABIC DAMMATAN
    .replaceAll('\u064D', '') //ARABIC KASRATAN
    .replaceAll('\u064E', '') //ARABIC FATHA
    .replaceAll('\u064F', '') //ARABIC DAMMA
    .replaceAll('\u0650', '') //ARABIC KASRA
    .replaceAll('\u0651', '') //ARABIC SHADDA
    .replaceAll('\u0652', '') //ARABIC SUKUN
    .replaceAll('\u0653', '') //ARABIC MADDAH ABOVE
    .replaceAll('\u0654', '') //ARABIC HAMZA ABOVE
    .replaceAll('\u0655', '') //ARABIC HAMZA BELOW
    .replaceAll('\u0656', '') //ARABIC SUBSCRIPT ALEF
    .replaceAll('\u0657', '') //ARABIC INVERTED DAMMA
    .replaceAll('\u0658', '') //ARABIC MARK NOON GHUNNA
    .replaceAll('\u0659', '') //ARABIC ZWARAKAY
    .replaceAll('\u065A', '') //ARABIC VOWEL SIGN SMALL V ABOVE
    .replaceAll('\u065B', '') //ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
    .replaceAll('\u065C', '') //ARABIC VOWEL SIGN DOT BELOW
    .replaceAll('\u065D', '') //ARABIC REVERSED DAMMA
    .replaceAll('\u065E', '') //ARABIC FATHA WITH TWO DOTS
    .replaceAll('\u065F', '') //ARABIC WAVY HAMZA BELOW
    .replaceAll('\u0670', '') //ARABIC LETTER SUPERSCRIPT ALEF

//Replace Waw Hamza Above by Waw
    .replaceAll('\u0624', '\u0648')

//Replace Ta Marbuta by Ha
    .replaceAll('\u0629', '\u0647')

//Replace Ya
// and Ya Hamza Above by Alif Maksura
    .replaceAll('\u064A', '\u0649')
    .replaceAll('\u0626', '\u0649')

// Replace Alifs with Hamza Above/Below
// and with Madda Above by Alif
    .replaceAll('\u0622', '\u0627')
    .replaceAll('\u0623', '\u0627')
    .replaceAll('\u0625', '\u0627');

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
            )..fillCommentMap()..fillFavMap()..fillDisFavMap(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'MOA',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppCubit.get(context).lightTheme,
            home: const TestPage(),
            // home: token != null ? const StartPage() : const LoginPage(),
          );
        },
      ),
    );
  }
}
