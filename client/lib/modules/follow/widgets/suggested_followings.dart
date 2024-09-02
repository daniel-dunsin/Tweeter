import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/bloc/follows_bloc.dart';
import 'package:client/modules/follow/widgets/user.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SuggestedFollowings extends StatefulWidget {
  const SuggestedFollowings({super.key});

  @override
  State<SuggestedFollowings> createState() => _SuggestedFollowingsState();
}

class _SuggestedFollowingsState extends State<SuggestedFollowings> {
  List<UserModel> users = [];

  @override
  void didChangeDependencies() {
    if (users.isEmpty) {
      context.read<FollowsBloc>().add(GetSuggestedFollowsRequested());
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return CupertinoActionSheet(
      actions: [
        Container(
          color: appColors.secondaryBackgroundColor,
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * .7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Text(
                  "Suggestions for you to follow",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: appColors.foregroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: const Text(
                  "When you follow someone, you'll see their tweets in your home timeline",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: .6,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                child: Text(
                  "You may be interested in",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: appColors.foregroundColor,
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: .6,
              ),
              const SizedBox(height: 10),
              BlocConsumer<FollowsBloc, FollowsState>(
                listener: (context, state) {
                  if (state is GetSuggestedFollowsSuccess) {
                    setState(() {
                      users = state.users;
                    });
                  }
                },
                builder: (context, state) {
                  return Visibility(
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final UserModel user = users[index];
                            return UserListTile(user: user);
                          },
                          itemCount: users.length,
                        ),
                      ),
                    ),
                    replacement: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: appColors.iconColor,
                        size: 20,
                        thirdRingColor: appColors.iconColor,
                        secondRingColor: appColors.iconColor,
                      ),
                    ),
                    visible: state is! GetSuggestedFollowsLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
