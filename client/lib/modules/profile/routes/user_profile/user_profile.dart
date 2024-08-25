import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/profile/bloc/profile_bloc.dart';
import 'package:client/modules/profile/routes/user_profile/widgets/app_bar.dart';
import 'package:client/shared/cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _scrollController = ScrollController();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUser();
  }

  _loadUser() async {
    if (user == null) {
      final userId = (ModalRoute.of(context)?.settings.arguments as Map<String, String?>)["userId"];
      final loggedInUser = context.read<AppCubit>().state.user;

      if (userId == loggedInUser?.id) {
        setState(() {
          user = loggedInUser;
        });
      } else {
        context.read<ProfileBloc>().add(GetProfileRequested(userId!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is GetProfileSuccess) {
            setState(() {
              user = state.user;
            });
          }

          if (state is GetProfileError) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              state is GetProfileSuccess
                  ? CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          expandedHeight: 400,
                          collapsedHeight: 70,
                          toolbarHeight: 70,
                          pinned: true,
                          floating: false,
                          flexibleSpace: UserProfileAppBar(
                            scrollController: _scrollController,
                            user: user,
                            followers: user?.followers,
                            followings: user?.followings,
                          ),
                        )
                      ],
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
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(88, 88, 88, 0.503),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: appColors.secondaryForegroundColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(88, 88, 88, 0.503),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.search_outlined,
                          color: appColors.secondaryForegroundColor,
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
    );
  }
}
