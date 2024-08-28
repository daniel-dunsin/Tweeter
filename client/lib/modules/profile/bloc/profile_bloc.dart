import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/profile/models/edit_profile_model.dart';
import 'package:client/modules/profile/repositories/profile_repository.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitialState()) {
    on<GetProfileRequested>(
      (event, emit) async {
        try {
          final response = await this.profileRepository.getUserProfile(event.userId);

          final Map<String, dynamic>? userMap = response["data"];

          if (userMap == null) {
            throw "User does not exist";
          }
          final user = UserModel.fromMap(userMap);

          emit(GetProfileSuccess(user));
        } catch (e) {
          handleError(e: e);
          emit(GetProfileError());
        }
      },
    );

    on<EditProfileRequested>((event, emit) async {
      emit(EditProfileLoading());
      try {
        final response = await this.profileRepository.editUserProfile(event.editProfileDto);

        final Map<String, dynamic> userMap = response["data"];

        final UserModel user = UserModel.fromMap(userMap);

        emit(EditProfileSuccess(user));
      } catch (e) {
        handleError(e: e);
        emit(EditProfileError());
      }
    });
  }
}
