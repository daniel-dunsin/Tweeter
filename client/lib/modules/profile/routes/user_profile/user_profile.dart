import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/profile/bloc/profile_bloc.dart';
import 'package:client/modules/profile/routes/user_profile/widgets/app_bar.dart';
import 'package:client/modules/profile/routes/user_profile/widgets/tabs.dart';
import 'package:client/modules/profile/utils/profile_utils.dart';
import 'package:client/modules/tweets/bloc/tweets_bloc.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  UserModel? user;
  List<UserModel>? followers;
  List<UserModel>? followings;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {});
      }
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUser();
    _getTweets();
  }

  _loadUser() async {
    if (user == null) {
      final loggedInUser = context.read<AppCubit>().state.user;
      final loggedInUserFollowers = context.read<AppCubit>().state.followers;
      final loggedInUserFollowings = context.read<AppCubit>().state.following;

      if (widget.userId == loggedInUser?.id) {
        setState(() {
          user = loggedInUser;
          followers = loggedInUserFollowers;
          followings = loggedInUserFollowings;
        });
      } else {
        context.read<ProfileBloc>().add(GetProfileRequested(widget.userId));
      }
    }
  }

  _getTweets() async {
    context.read<TweetsBloc>().add(GetUserTweetsRequested(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final loggedInUser = context.watch<AppCubit>().state.user!;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadUser();
          await _getTweets();
        },
        color: appColors.iconColor,
        backgroundColor: appColors.secondaryBackgroundColor,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is GetProfileSuccess) {
              setState(() {
                user = state.user;
                followings = followingsToUsers(state.user.followings ?? []);
                followers = followersToUsers(state.user.followers ?? []);
              });
            }

            if (state is GetProfileError) {
              GoRouter.of(context).pop();
            }
          },
          builder: (context, profileState) {
            return Stack(
              children: [
                profileState is! GetProfileLoading
                    ? Visibility(
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            UserProfileAppBar(
                              scrollController: _scrollController,
                              user: user?.id == loggedInUser.id ? loggedInUser : user,
                              followers: followers,
                              followings: followings,
                              tabController: _tabController,
                            ),
                            SliverToBoxAdapter(
                              child: UserProfileTabs(
                                tabController: _tabController,
                              ),
                            ),
                          ],
                        ),
                        visible: user != null,
                      )
                    : Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: appColors.iconColor,
                          size: 40,
                          secondRingColor: appColors.iconColor,
                          thirdRingColor: appColors.iconColor,
                        ),
                      ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(88, 88, 88, 0.803),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: appColors.foregroundColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(88, 88, 88, 0.803),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.search_outlined,
                            color: appColors.foregroundColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
