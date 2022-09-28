import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/models/government_model.dart';
import 'package:moa/core/models/login_model.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/translation.dart';
import '../../models/all_requests_model.dart';
import '../../models/register_model.dart';
import '../../network/repository.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  AppCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());


  static AppCubit get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = true;
  bool isRtlChange = true;

  late ThemeData lightTheme;

  late String family;

  void setThemes({
    required bool rtl,
  }) {
    isRtl = rtl;
    isRtlChange = rtl;

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Cairo';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: whiteColor,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariant),
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariant),
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(15.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondary),
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(15.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
        ),
        caption: TextStyle(
          fontSize: pxToDp(11.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondary),
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),
      ),
    );
  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerFullNameController = TextEditingController();
  final registerIdController = TextEditingController();
  final registerMobileController = TextEditingController();
  final registerAddressController = TextEditingController();
  final registerEmailAddressController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  GovernmentModel? selectedGovernment;

  void changeSelectedGovernment({
    required GovernmentModel value,
  }) {
    selectedGovernment = value;
    emit(ChangeSelectedGovernment());
  }

  PageController pageController = PageController();

  int currentIndex = 0;

  void bottomChanged(int index, context) {
    if (index == 2) {
      showLogoutDialog(
        context: context,
        function: () {
          signOut(
            context,
          );
        },
      );
      return;
    }

    currentIndex = index;

    pageController.jumpToPage(
      index,
    );

    emit(BottomChanged());
  }

  LoginModel? loginModel;

  void userLogin() async {
    emit(UserLoginLoading());

    String? token = await FirebaseMessaging.instance.getToken();

    final result = await _repository.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
      token: token,
    );

    result.fold(
      (failure) {
        emit(
          UserLoginError(
            message: failure,
          ),
        );
      },
      (data) {
        loginModel = data;

        emit(UserLoginSuccess(
          token: loginModel!.token,
        ));
      },
    );
  }

  List<GovernmentModel> governmentsList = [];

  void getAllGovernments() async {
    emit(GetAllGovernmentsLoading());

    final result = await _repository.getAllGovernments();

    result.fold(
      (failure) {
        emit(
          GetAllGovernmentsError(
            message: failure,
          ),
        );
      },
      (data) {
        governmentsList = data;

        selectedGovernment = governmentsList[1];

        emit(GetAllGovernmentsSuccess());
      },
    );
  }

  RegisterModel? registerModel;

  void userRegister() async {
    emit(UserRegisterLoading());

    final result = await _repository.register(
      name: registerFullNameController.text,
      email: registerEmailAddressController.text,
      mobile: registerMobileController.text,
      nationalityId: registerIdController.text,
      password: registerPasswordController.text,
      cPassword: registerConfirmPasswordController.text,
      address: registerAddressController.text,
      governorateId: selectedGovernment!.id,
    );

    result.fold(
      (failure) {
        emit(
          UserRegisterError(
            message: failure,
          ),
        );
      },
      (data) {
        registerModel = data;
        if(registerModel!.isSuccess) {
          emit(UserRegisterSuccess());
        } else {
          emit(
            UserRegisterError(
              message: registerModel!.message,
            ),
          );
        }
      },
    );
  }

  List<AllRequestsDataModel> requests = [];

  void myRequests() async {
    emit(AllRequestedLoading());

    final result = await _repository.getAllRequested();

    result.fold(
      (failure) {
        debugPrint(failure.toString());
        emit(
          AllRequestedError(
            message: failure,
          ),
        );
      },
      (data) {
        requests = data;

        emit(AllRequestedSuccess());
      },
    );
  }

  bool isLoaded = false;

  void changeLoad({
    required bool load,
  }) {
    isLoaded = load;
    emit(ChangeLoaded());
  }

//   Future<void> _createPDF() async {
//     PdfDocument document = PdfDocument();
//     document.pages.add();
//
//
//     List<int> bytes = document.save();
//
//     saveAndLaunchFile(bytes, 'Output.pdf');
//
//     emit(PrintRequestPDF());
// }




  // Future<void> printRequestPDF() async {
  //   final pdf = pw.Document();
  //
  //   // pdf.addPage(
  //   //   pw.Page(
  //   //     build: (pw.Context context) => pw.Center(
  //   //       child: pw.Text('Hello World!',
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  //
  //   // final Uint8List fontData = File('Cairo-Regular.ttf').readAsBytesSync();
  //   // final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  //   //
  //   // pdf.addPage(pw.Page(
  //   //     pageFormat: PdfPageFormat.a4,
  //   //     build: (pw.Context context) {
  //   //       return pw.Center(
  //   //         child: pw.Text('Hello World', style: pw.TextStyle(font: ttf, fontSize: 40)),
  //   //       ); // Center
  //   //     }));
  //
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //
  //   pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text('Hello World', style: pw.TextStyle(font: font, fontSize: 40)),
  //         ); // Center
  //       }));
  //
  //
  //   final file = File('example.pdf');
  //   await file.writeAsBytes(await pdf.save());
  //
  //   emit(PrintRequestPDF());
  // }
}
