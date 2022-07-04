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

class FieldsWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  FieldsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is UserLoginError) {
          Fluttertoast.showToast(msg: state.message,);
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
                      appTranslation(context).fieldsHead,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6,
                    ),
                    space40Vertical(context),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => MyForm(
                      isPassword: false,
                      type: TextInputType.text,
                      error: appTranslation(context).fieldsError + AppCubit.get(context).requiredFieldsMap.keys.toList()[index].toLowerCase(),
                      controller: AppCubit.get(context).requiredFieldsMap.values.toList()[index],
                      label: AppCubit.get(context).requiredFieldsMap.keys.toList()[index],
                    ),
                      separatorBuilder: (context, index) =>
                          space20Vertical(context),
                      itemCount: AppCubit.get(context).requiredFieldsMap.length,),
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