import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';

class ChangeChooseView extends StatelessWidget {
  const ChangeChooseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          key: const ValueKey(SettingsKeys.backIcon),

          onPressed: () {
            BlocProvider.of<SettingsWebCubit>(context).toggleMenu(0);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          "Account Information",
          textAlign: TextAlign.left,
        ),
      ),
      body: Column(
        children: [
          CustomdataDisplay(
            title: "Username",
            subtitle: TempUser.username,
            onpress: () {
              BlocProvider.of<SettingsWebCubit>(context).toggleMenu(5);
            },
          ),
          CustomdataDisplay(
            title: "Email",
            subtitle: TempUser.email,
            onpress: () {
              BlocProvider.of<SettingsWebCubit>(context).toggleMenu(4);
            },
          ),
        ],
      ),
    );
  }
}
