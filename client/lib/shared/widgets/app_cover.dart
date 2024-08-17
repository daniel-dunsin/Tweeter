import 'package:client/shared/theme/index.dart';
import 'package:flutter/material.dart';

class AppCover extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;

  const AppCover({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height - 50 - (appBar?.toolbarHeight ?? 0),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: CustomTheme.majorScreenPadding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
