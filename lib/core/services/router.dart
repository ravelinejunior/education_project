import 'package:education_project/core/common/views/page_under_construction.dart';
import 'package:education_project/core/services/injection_container.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (context) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
