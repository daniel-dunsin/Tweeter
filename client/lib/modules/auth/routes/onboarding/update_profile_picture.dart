import 'dart:io';

import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/utils/file.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/cancel_appbar_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProfilePictureScreen extends StatefulWidget {
  const UpdateProfilePictureScreen({super.key});

  @override
  State<UpdateProfilePictureScreen> createState() => _UpdateProfilePictureScreenState();
}

class _UpdateProfilePictureScreenState extends State<UpdateProfilePictureScreen> {
  File? pickedImage;

  @override
  void initState() {
    super.initState();
  }

  void submit() async {
    if (pickedImage != null) {
      context.read<AuthBloc>().add(UpdateProfilePictureRequested(pickedImage!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCover(
      appBar: AppBar(
        actions: [
          SkipAppBarAction(
            onPressed: () {
              GoRouter.of(context).pushNamed(AuthRoutes.selectInterests);
            },
          ),
        ],
        toolbarHeight: 50,
      ),
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is UpdateProfilePictureSuccess) {
          GoRouter.of(context).goNamed(AuthRoutes.selectInterests);
        }
      }, builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Pick a profile picture",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Have a favourite selfie? Upload it now",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (state is! UpdateProfilePictureLoading) {
                      final image = await pickImage();
                      if (image != null) {
                        setState(() {
                          pickedImage = image;
                        });
                      }
                    }
                  },
                  child: Visibility(
                    child: pickedImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                              pickedImage!,
                            ),
                          )
                        : const SizedBox(),
                    replacement: Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: Colors.grey,
                          ),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              Icons.person,
                              size: 200,
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: const Color.fromARGB(150, 0, 0, 0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.photo_camera_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                    visible: pickedImage != null,
                  ),
                ),
              ),
            ),
            const Spacer(),
            ContainedButton(
              disabled: pickedImage == null,
              child: const Text("Upload"),
              onPressed: () {
                submit();
              },
              fullWidth: true,
              loading: state is UpdateProfilePictureLoading,
            ),
          ],
        );
      }),
    );
  }
}
