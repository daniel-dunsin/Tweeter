import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class TweeterLoader extends StatelessWidget {
  const TweeterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Theme.of(context).appColors.iconColor,
      ),
    );
  }
}
