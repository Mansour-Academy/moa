import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/logo.dart';
import 'package:moa/core/util/widgets/my_button.dart';
import 'package:moa/core/util/widgets/my_form.dart';
import 'package:moa/features/fields/presentation/pages/fields_page.dart';
import 'package:moa/features/test/presentation/pages/test_page.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/network/remote/api_endpoints.dart';

class RegisterWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CompanyDomainError) {
          Fluttertoast.showToast(
            msg: state.message,
          );
        }

        if (state is CompanyDomainSuccess) {
          navigateTo(
            context,
            const FieldsPage(),
          );
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
                      appTranslation(context).companyDomainHead,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    space40Vertical(context),
                    MyForm(
                      isPassword: false,
                      type: TextInputType.text,
                      error: appTranslation(context).companyDomainError,
                      controller: AppCubit.get(context).companyDomainController,
                      label: appTranslation(context).companyDomain,
                    ),
                    space40Vertical(context),
                    MyButton(
                      isLoading: state is CompanyDomainLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          AppCubit.get(context).companyDomain();
                        }
                      },
                      text: appTranslation(context).next,
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
