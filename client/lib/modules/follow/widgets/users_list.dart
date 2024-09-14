import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/widgets/user.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final List<UserModel> users;
  final Widget? replacement;
  const UsersList({super.key, required this.users, this.replacement});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return UserListTile(user: users[index]);
        },
        itemCount: users.length,
      ),
      visible: users.isNotEmpty,
      replacement: replacement ?? const SizedBox.shrink(),
    );
  }
}
