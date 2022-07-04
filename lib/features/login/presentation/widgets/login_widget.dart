import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/my_form.dart';
import 'package:moa/features/test/presentation/pages/test_page.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_endpoints.dart';

class LoginWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is UserLoginError) {
          Fluttertoast.showToast(msg: appTranslation(context).loginError,);
        }

        if(state is UserLoginSuccess) {
          sl<CacheHelper>().put('token', state.token);
          sl<CacheHelper>().put('companyName', state.companyName);
          token = state.token;
          companyName = state.companyName;

          navigateAndFinish(context, const TestPage());
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
                    Text(
                      appTranslation(context).loginHead,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    space40Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.emailAddress,
                      error: appTranslation(context).emailAddressError,
                      controller: AppCubit.get(context).loginEmailController,
                      label: appTranslation(context).emailAddress,
                    ),
                    space8Vertical(context),
                    MyForm(
                      isPassword: true,
                      type: TextInputType.visiblePassword,
                      error: appTranslation(context).passwordError,
                      controller: AppCubit.get(context).loginPasswordController,
                      label: appTranslation(context).password,
                    ),
                    space40Vertical(context),
                    MyButton(
                      isLoading: state is UserLoginLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          AppCubit.get(context).userLogin();
                        }
                      },
                      text: appTranslation(context).loginHead,
                    ),
                    space10Vertical(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appTranslation(context).donNotHaveAccount,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextButton(
                          onPressed: () {
                            // AppCubit.get(context).getAllGovernments();
                            // navigateTo(
                            //   context,
                            //   const RegisterPage(),
                            // );
                          },
                          child: Text(
                            appTranslation(context).registerNow,
                          ),
                        ),
                      ],
                    ),
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