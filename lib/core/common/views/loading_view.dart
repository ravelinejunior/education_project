import 'package:education_project/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
