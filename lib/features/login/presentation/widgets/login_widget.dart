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
import 'package:moa/features/main/presentation/pages/main_page.dart';
import 'package:moa/features/register/presentation/pages/register_page.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_endpoints.dart';
import '../../../my_requests/presentation/pages/my_requests_page.dart';

class LoginWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is UserLoginError) {
          Fluttertoast.showToast(msg: state.message);
        }

        if(state is UserLoginSuccess) {
          sl<CacheHelper>().put('token', state.token);
          token = state.token;

          navigateAndFinish(context, const MyRequestsPage());
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
                            appTranslation(context).loginHead,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
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
                            AppCubit.get(context).getAllGovernments();

                            navigateTo(
                              context,
                              const RegisterPage(),
                            );
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
