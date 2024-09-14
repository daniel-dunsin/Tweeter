import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/models/user_follows_model.dart';
import 'package:client/modules/follow/repository/follow_repository.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'follows_events.dart';
part 'follows_state.dart';

class FollowsBloc extends Bloc<FollowsEvents, FollowsState> {
  final FollowRepository followRepository;
  final AppCubit appCubit;

  FollowsBloc({required this.followRepository, required this.appCubit}) : super(FollowsInitialState()) {
    on<GetUserFollowsRequested>(
      (event, emit) async {
        emit(GetUserFollowsLoading());

        try {
          final response = await followRepository.getUserFollows(event.userId);

          final Map<String, dynamic>? data = response["data"];

          if (data != null) {
            final verifiedFollowers = data["verifiedFollowers"];
            final followers = data["followers"];
            final followings = data["followings"];

            emit(
              GetUserFollowsSuccess(
                UserFollowsModel.fromMap(
                  {
                    "followers": followers,
                    "followings": followings,
                    "verifiedFollowers": verifiedFollowers,
                  },
                ),
              ),
            );
          }
        } catch (e) {
          handleError(e: e);
          emit(GetUserFollowsError());
        }
      },
    );

    on<GetSuggestedFollowsRequested>((event, emit) async {
      emit(GetSuggestedFollowsLoading());

      try {
        final response = await followRepository.getSuggestedFollows();

        final usersMap = response["data"] as List<dynamic>;

        final List<UserModel> users = usersMap.map((user) => UserModel.fromMap(user)).toList();

        emit(GetSuggestedFollowsSuccess(users));
      } catch (e) {
        handleError(e: e);
        emit(GetSuggestedFollowsError());
      }
    });
  }
}
