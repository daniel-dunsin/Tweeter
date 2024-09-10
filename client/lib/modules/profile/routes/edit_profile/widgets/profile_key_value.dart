import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfileKeyValue extends StatelessWidget {
  final String profileKey;
  final TextEditingController controller;
  final bool? enforceMinLine;
  final bool disableInput;

  const ProfileKeyValue({
    super.key,
    required this.profileKey,
    required this.controller,
    this.enforceMinLine,
    this.disableInput = false,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: this.enforceMinLine == true ? 2 : 5, horizontal: 8),
      child: Row(
        crossAxisAlignment: enforceMinLine == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              "$profileKey",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: TextFormField(
              controller: controller,
              cursorColor: appColors.iconColor,
              maxLines: 3,
              minLines: enforceMinLine == true ? 1 : null,
              enabled: !disableInput,
              maxLength: 180,
              style: TextStyle(
                color: appColors.iconColor,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(1),
                counterText: enforceMinLine == true ? '' : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
