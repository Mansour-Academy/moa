import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/features/main/presentation/pages/main_page.dart';
import 'package:moa/features/my_requests/presentation/pages/my_requests_page.dart';
import 'package:moa/features/start/presentation/widgets/start_item.dart';

class StartWidget extends StatelessWidget {
  const StartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StartItem(
                  image: 'earth',
                  text: appTranslation(context).browse,
                  onTap: () {
                    navigateTo(context, const MainPage());
                  },
                ),
                space8Vertical(context),
                StartItem(
                  image: 'documents',
                  text: appTranslation(context).myRequests,
                  onTap: () {
                    navigateTo(context, const MyRequestsPage());

                  },
                ),
                space8Vertical(context),
                StartItem(
                  image: 'logout',
                  text: appTranslation(context).logout,
                  onTap: () {
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
