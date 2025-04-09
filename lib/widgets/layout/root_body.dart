import 'package:breadcrumbs/utils/loading/loading.dart';
import 'package:flutter/material.dart';

class RootBody extends StatelessWidget {
  const RootBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return LoadingScreen(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: viewportConstraints.maxHeight,
        ),
        child: child,
      ));
    });
  }
}
