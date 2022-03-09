import 'dart:convert';
import 'dart:io';

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

    final result = await _repository.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
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

        selectedGovernment = governmentsList[0];

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

        emit(UserRegisterSuccess());
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
}
