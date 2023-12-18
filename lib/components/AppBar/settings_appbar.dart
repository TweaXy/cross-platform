import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/services/temp_user.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({
    super.key,
    required this.title,
    this.showUsername,
  });
  final String title;
  final bool? showUsername;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUsernameCubit, UpdateUsernameStates>(
      builder: (context, state) {
        return AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 0.4,
                ),
              ),
              if (showUsername == null || showUsername == true)
                Text(
                  '@${TempUser.username}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                ),
            ],
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
