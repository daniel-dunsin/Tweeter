import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfileKeyValue extends StatelessWidget {
  final String profileKey;
  final TextEditingController controller;
  final bool? enforceMinLine;
  final bool disableInput;
  final double keyWidth;
  final String? placeholder;
  final bool obscureInput;

  const ProfileKeyValue({
    super.key,
    required this.profileKey,
    required this.controller,
    this.enforceMinLine,
    this.disableInput = false,
    this.keyWidth = 70,
    this.placeholder,
    this.obscureInput = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: enforceMinLine == true ? 2 : 5, horizontal: 8),
      child: Row(
        crossAxisAlignment: enforceMinLine == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: keyWidth,
            child: Text(
              profileKey,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: appColors.iconColor,
              maxLines: enforceMinLine == true ? 1 : 3,
              minLines: enforceMinLine == true ? 1 : null,
              enabled: !disableInput,
              obscureText: obscureInput,
              maxLength: 180,
              style: TextStyle(
                color: appColors.iconColor,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(1),
                counterText: enforceMinLine == true ? '' : null,
                hintText: placeholder,
              ),
            ),
          )
        ],
      ),
    );
  }
}
