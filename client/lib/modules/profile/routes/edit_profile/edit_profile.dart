import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/profile/bloc/profile_bloc.dart';
import 'package:client/modules/profile/models/edit_profile_model.dart';
import 'package:client/modules/profile/routes/edit_profile/widgets/profile_key_value.dart';
import 'package:client/shared/constants/images.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel initialUser;
  const EditProfileScreen({
    super.key,
    required this.initialUser,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final UserModel user;
  late final nameController = TextEditingController(text: widget.initialUser.name);
  late final bioController = TextEditingController(text: widget.initialUser.bio);
  late final websiteController = TextEditingController(text: widget.initialUser.website);

  late EditProfileModel _editProfileModel = EditProfileModel(
    name: widget.initialUser.name,
    bio: widget.initialUser.bio,
    website: widget.initialUser.website,
  );

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      setState(() {
        _editProfileModel = _editProfileModel.copyWith(name: nameController.text);
      });
    });
    bioController.addListener(() {
      _editProfileModel = _editProfileModel.copyWith(bio: bioController.text);
    });
    websiteController.addListener(() {
      _editProfileModel = _editProfileModel.copyWith(website: websiteController.text);
    });
  }

  void submit() async {
    context.read<ProfileBloc>().add(EditProfileRequested(_editProfileModel));
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    bioController.dispose();
    websiteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final profileBloc = context.read<ProfileBloc>();
    final user = context.watch<AppCubit>().state.user!;

    return FractionallySizedBox(
      heightFactor: 0.90,
      widthFactor: 1,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          final bool saveDisabled = state is DeleteProfilePictureLoading || state is DeleteCoverPictureLoading || state is EditProfileLoading;

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                color: appColors.backgroundColor,
              ),
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 15,
                                color: appColors.foregroundColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: appColors.foregroundColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (!saveDisabled) {
                                submit();
                              }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 15,
                                color: saveDisabled ? Colors.grey : appColors.foregroundColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final file = await pickImage();

                            if (file != null) {
                              setState(() {
                                _editProfileModel = _editProfileModel.copyWith(coverPicture: file);
                              });
                            }
                          },
                          child: Visibility(
                            child: Stack(
                              children: [
                                _editProfileModel.coverPicture == null
                                    ? Image.network(
                                        user.coverPicture ?? "",
                                        width: double.maxFinite,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        _editProfileModel.coverPicture!,
                                        width: double.maxFinite,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                Positioned(
                                  right: 14,
                                  top: 14,
                                  child: IconButton(
                                    color: appColors.iconColor,
                                    onPressed: () {
                                      if (_editProfileModel.coverPicture != null) {
                                        setState(() {
                                          _editProfileModel = _editProfileModel.copyWith(coverPicture: null, coverPictureSetToNull: true);
                                        });
                                      } else {
                                        profileBloc.add(DeleteCoverPictureRequested());
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            replacement: Container(
                              height: 150,
                              width: double.maxFinite,
                              color: appColors.secondaryBackgroundColor,
                              child: Center(
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: appColors.secondaryForegroundColor,
                                ),
                              ),
                            ),
                            visible: user.coverPicture != null || _editProfileModel.coverPicture != null,
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 10,
                          child: GestureDetector(
                            onTap: () async {
                              final file = await pickImage();

                              if (file != null) {
                                setState(() {
                                  _editProfileModel = _editProfileModel.copyWith(profilePicture: file);
                                });
                              }
                            },
                            child: CircleAvatar(
                              backgroundImage: _editProfileModel.profilePicture == null ? NetworkImage(user.profilePicture) : FileImage(_editProfileModel.profilePicture!),
                              radius: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0.5),
                                      Color.fromRGBO(0, 0, 0, 0.5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.photo_camera_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        user.profilePicture != AppImages.placeholderImage || _editProfileModel.profilePicture != null
                            ? Positioned(
                                top: 145,
                                left: 65,
                                child: IconButton(
                                  onPressed: () {
                                    if (_editProfileModel.profilePicture != null) {
                                      _editProfileModel = _editProfileModel.copyWith(profilePicture: null, profilePictureSetToNull: true);
                                    } else {
                                      profileBloc.add(DeleteProfilePictureRequested());
                                    }
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: appColors.iconColor,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Divider(height: 0.5, color: Colors.grey),
                          ProfileKeyValue(
                            profileKey: "Name",
                            enforceMinLine: true,
                            controller: nameController,
                          ),
                          const Divider(height: 0.5, color: Colors.grey),
                          const Divider(height: 0.5, color: Colors.grey),
                          ProfileKeyValue(
                            profileKey: "Bio",
                            controller: bioController,
                          ),
                          const Divider(height: 0.5, color: Colors.grey),
                          const Divider(height: 0.5, color: Colors.grey),
                          ProfileKeyValue(
                            profileKey: "Website",
                            enforceMinLine: true,
                            controller: websiteController,
                          ),
                          const Divider(height: 0.5, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
