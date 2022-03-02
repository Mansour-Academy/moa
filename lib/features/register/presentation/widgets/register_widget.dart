import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/my_form.dart';
import 'package:moa/features/login/presentation/pages/login_page.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/models/government_model.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_endpoints.dart';
import '../../../start/presentation/pages/start_page.dart';

// const List<String> cities = [
//   'اختر',
//   'القاهرة',
//   'دمياط',
//   'الدقهلية',
//   'الشرقية',
//   'القليوبية',
//   'كفر الشيخ',
//   'الغربية',
//   'المنوفية',
//   'البحيرة',
//   'الإسماعيلية',
//   'الإسكندرية',
//   'الجيزة',
//   'بني سويف',
//   'الفيوم',
//   'المنيا',
//   'أسيوط',
//   'سوهاج',
//   'قنا',
//   'أسوان',
//   'الأقصر',
//   'بورسعيد',
//   'البحر الأحمر',
//   'الوادي الجديد',
//   'مطروح',
//   'شمال سيناء',
//   'جنوب سيناء',
//   'السويس',
//   'حلوان',
//   '6 اكتوبر',
//   'خارج الجمهورية',
// ];

class RegisterWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is UserRegisterError) {
          Fluttertoast.showToast(msg: state.message);
        }

        if(state is UserRegisterSuccess) {
          navigateAndFinish(context, const LoginPage());
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsiveValue(
              context,
              16.0,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Column(
                        children: [
                          const AppLogo(),
                          Text(
                            appTranslation(context).registerHead,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    space40Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.name,
                      error: appTranslation(context).fullNameError,
                      controller:
                          AppCubit.get(context).registerFullNameController,
                      label: appTranslation(context).fullName,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.number,
                      error: appTranslation(context).nationalIdError,
                      controller: AppCubit.get(context).registerIdController,
                      label: appTranslation(context).nationalId,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.phone,
                      error: appTranslation(context).mobileNumberError,
                      controller:
                          AppCubit.get(context).registerMobileController,
                      label: appTranslation(context).mobileNumber,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.text,
                      error: appTranslation(context).addressError,
                      controller:
                          AppCubit.get(context).registerAddressController,
                      label: appTranslation(context).address,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.emailAddress,
                      error: appTranslation(context).emailAddressError,
                      controller:
                          AppCubit.get(context).registerEmailAddressController,
                      label: appTranslation(context).emailAddress,
                    ),
                    space8Vertical(context),
                    if (AppCubit.get(context).governmentsList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appTranslation(context).government,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          space8Vertical(context),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              border: Border.all(
                                color: HexColor(darkGreyColor),
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: responsiveValue(
                                context,
                                16.0,
                              ),
                            ),
                            child: DropdownButton<GovernmentModel>(
                              value: AppCubit.get(context).selectedGovernment,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: HexColor(mainColor),
                                  ),
                              onChanged: (GovernmentModel? newValue) {
                                AppCubit.get(context).changeSelectedGovernment(
                                  value: newValue!,
                                );
                              },
                              isExpanded: true,
                              underline: Container(),
                              items: AppCubit.get(context)
                                  .governmentsList
                                  .map<DropdownMenuItem<GovernmentModel>>(
                                (GovernmentModel value) {
                                  return DropdownMenuItem<GovernmentModel>(
                                    value: value,
                                    child: Text(value.description),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                      error: appTranslation(context).passwordError,
                      controller:
                          AppCubit.get(context).registerPasswordController,
                      label: appTranslation(context).password,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                      error: appTranslation(context).confirmPasswordError,
                      controller: AppCubit.get(context)
                          .registerConfirmPasswordController,
                      label: appTranslation(context).confirmPassword,
                    ),
                    space40Vertical(context),
                    MyButton(
                      isLoading: state is UserRegisterLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).userRegister();
                        }
                      },
                      text: appTranslation(context).registerNow,
                    ),
                    space40Vertical(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
