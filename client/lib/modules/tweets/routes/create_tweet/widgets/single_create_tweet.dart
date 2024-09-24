import 'package:client/modules/settings/widgets/binary_confirmation_dialog.dart';
import 'package:client/modules/tweets/routes/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:client/shared/constants/misc.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SingleCreateTweet extends StatefulWidget {
  final int index;

  SingleCreateTweet({super.key, required this.index});

  @override
  State<SingleCreateTweet> createState() => _SingleCreateTweetState();
}

class _SingleCreateTweetState extends State<SingleCreateTweet> {
  final GlobalKey _textFieldKey = GlobalKey();
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  double _textFieldHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTextFieldHeight();
      focusNode.requestFocus();
    });
    controller.addListener(() {
      _updateTextFieldHeight();
      context.read<CreateTweetBloc>().add(AddText(controller.text));
    });
  }

  void _updateTextFieldHeight() {
    final RenderBox? renderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      setState(() {
        _textFieldHeight = renderBox.size.height;
      });
    }
  }

  void _removeTweet() => context.read<CreateTweetBloc>().add(RemoveTweet(index: widget.index));

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppCubit>().state.user!;
    final appColors = Theme.of(context).appColors;
    final createTweetState = context.watch<CreateTweetBloc>().state;

    final bool nextPostExists = createTweetState.tweets.length > widget.index + 1;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                AnimatedOpacity(
                  opacity: nextPostExists ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: IntrinsicHeight(
                    child: Container(
                      width: 1,
                      height: _textFieldHeight,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          controller: controller,
                          key: _textFieldKey,
                          cursorColor: appColors.iconColor,
                          cursorWidth: 3,
                          maxLines: 10,
                          minLines: 1,
                          maxLength: maxCharacterCount,
                          style: TextStyle(
                            fontSize: 11.h,
                          ),
                          decoration: InputDecoration(
                            counter: const SizedBox.shrink(),
                            contentPadding: const EdgeInsets.all(0),
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: widget.index > 0 ? "Add another post" : "What's happening here?",
                            hintStyle: TextStyle(
                              fontSize: 11.h,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      ...(widget.index > 0
                          ? [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => BinaryConfirmationDialog(
                                      onYes: () {
                                        _removeTweet();
                                        GoRouter.of(context).pop();
                                      },
                                      message: "Deleting this post will cause your content to be lost. Are you sure you want to delete?",
                                      title: "Delete Post?",
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 16.h,
                                ),
                              )
                            ]
                          : [])
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
