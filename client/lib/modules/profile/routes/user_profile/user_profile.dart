import 'package:client/modules/profile/routes/user_profile/widgets/app_bar.dart';
import 'package:client/shared/cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final user = context.read<AppCubit>().state.user;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              UserProfileAppBar(scrollController: _scrollController),
            ],
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
      ),
    );
  }
}
