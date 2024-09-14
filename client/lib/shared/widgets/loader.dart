import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class TweeterLoader extends StatelessWidget {
  const TweeterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        color: Theme.of(context).appColors.iconColor,
      ),
    );
  }
}
