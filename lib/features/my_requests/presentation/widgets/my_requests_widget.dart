import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moa/core/util/constants.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';
import 'package:moa/core/util/widgets/my_indicator.dart';

import '../../../../core/util/constants.dart';
import 'my_requests_item.dart';

class MyRequestsWidget extends StatefulWidget {
  const MyRequestsWidget({Key? key}) : super(key: key);

  @override
  State<MyRequestsWidget> createState() => _MyRequestsWidgetState();
}

class _MyRequestsWidgetState extends State<MyRequestsWidget> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).myRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is AllRequestedLoading) {
          return const MyIndicator();
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => MyRequestsItem(model: AppCubit.get(context).requests[index],),
          separatorBuilder: (context, index) => space8Vertical(context),
          itemCount: AppCubit.get(context).requests.length,
        );
      },
    );
  }
}
