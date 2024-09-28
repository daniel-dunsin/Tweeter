import 'package:client/modules/tweets/bloc/tweets_bloc.dart';
import 'package:client/modules/tweets/models/tweet_list_model.dart';
import 'package:client/modules/tweets/widgets/tweets_list.dart';
import 'package:client/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileTabs extends StatefulWidget {
  final TabController tabController;

  const UserProfileTabs({
    super.key,
    required this.tabController,
  });

  @override
  State<UserProfileTabs> createState() => _UserProfileTabsState();
}

class _UserProfileTabsState extends State<UserProfileTabs> {
  List<TweetListModel> posts = [];
  List<TweetListModel> replies = [];
  List<TweetListModel> media = [];
  List<TweetListModel> likes = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: BlocConsumer<TweetsBloc, TweetsState>(
        listener: (context, state) {
          if (state is GetUserTweetsSuccessful) {
            setState(
              () {
                posts = state.posts;
                media = state.media;
                replies = state.replies;
                likes = state.likes;
              },
            );
          }
        },
        builder: (context, state) {
          return TabBarView(
            controller: widget.tabController,
            children: [
              TweetsList(
                tweets: posts,
                loading: state is GetUserTweetsLoading,
              ),
              TweetsList(
                tweets: replies,
                loading: state is GetUserTweetsLoading,
              ),
              TweetsList(
                tweets: media,
                loading: state is GetUserTweetsLoading,
              ),
              TweetsList(
                tweets: likes,
                loading: state is GetUserTweetsLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}
