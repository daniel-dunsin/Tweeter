import 'dart:io';

import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/profile/models/edit_profile_model.dart';
import 'package:client/modules/profile/routes/edit_profile/widgets/profile_key_value.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/file.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileModel _editProfileModel = EditProfileModel();
  late final nameController = TextEditingController(text: widget.user.name);
  late final bioController = TextEditingController(text: widget.user.bio);
  late final websiteController = TextEditingController(text: widget.user.website);

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

    return FractionallySizedBox(
      heightFactor: 0.90,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: appColors.backgroundColor,
          ),
          height: double.maxFinite,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                        child: _editProfileModel.coverPicture == null
                            ? Image.network(
                                widget.user.coverPicture ?? "",
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
                        visible: widget.user.coverPicture != null || _editProfileModel.coverPicture != null,
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
                          backgroundImage: _editProfileModel.profilePicture == null ? NetworkImage(widget.user.profilePicture) : FileImage(_editProfileModel.profilePicture!),
                          radius: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0.5),
                                  Color.fromRGBO(0, 0, 0, 0.5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                      Divider(height: 0.5, color: Colors.grey),
                      const Divider(height: 0.5, color: Colors.grey),
                      ProfileKeyValue(
                        profileKey: "Bio",
                        controller: bioController,
                      ),
                      Divider(height: 0.5, color: Colors.grey),
                      const Divider(height: 0.5, color: Colors.grey),
                      ProfileKeyValue(
                        profileKey: "Website",
                        enforceMinLine: true,
                        controller: websiteController,
                      ),
                      Divider(height: 0.5, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
