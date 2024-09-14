import 'package:client/modules/follow/widgets/suggested_followings.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class NoFollowing extends StatelessWidget {
  final String message;
  final bool showSuggestion;

  const NoFollowing({
    super.key,
    required this.message,
    required this.showSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: appColors.foregroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            child: ContainedButton(
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  "Suggested Users",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  barrierColor: const Color.fromRGBO(43, 43, 43, 0.6),
                  context: context,
                  isScrollControlled: true,
                  enableDrag: true,
                  builder: (context) {
                    return const SuggestedFollowings();
                  },
                );
              },
            ),
            visible: showSuggestion,
          )
        ],
      ),
    );
  }
}
