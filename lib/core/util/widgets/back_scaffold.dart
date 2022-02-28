import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moa/core/util/cubit/cubit.dart';
import 'package:moa/core/util/cubit/state.dart';

class BackScaffold extends StatelessWidget {
  final Widget body;
  double elevation;

  BackScaffold({
    Key? key,
    required this.body,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: elevation,
            shadowColor: Colors.grey[100],
          ),
          body: body,
        );
      },
    );
  }
}
