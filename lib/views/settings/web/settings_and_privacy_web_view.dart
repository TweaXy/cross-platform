import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/views/settings/web/account_info_web_view.dart';
import 'package:tweaxy/cubits/setting-web-cubit/setting_web_states.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/views/settings/web/email_update_web.dart';
import 'package:tweaxy/views/settings/web/verify-password.dart';

class SettingsAndPrivacyWeb extends StatefulWidget {
  const SettingsAndPrivacyWeb({
    super.key,
  });

  @override
  State<SettingsAndPrivacyWeb> createState() => _SettingsAndPrivacyWebState();
}

class _SettingsAndPrivacyWebState extends State<SettingsAndPrivacyWeb> {
  int selectedItem = 0;
  int item = 0;
  @override
  void initState() {
    super.initState();
    selectedItem = 1;
    item = 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsWebCubit(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                  right: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text("Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 20,
                          letterSpacing: 0.4,
                        )),
                  ),
                  ListTile(
                    shape: Border(
                      right: BorderSide(
                        color: selectedItem == 1 ? Colors.blue : Colors.white,
                        width: 2.0,
                      ),
                    ),
                    onTap: () {
                      _globalOnTap(1);
                    },
                    title: const Text("Your account"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  ListTile(
                    shape: Border(
                      right: BorderSide(
                        color: selectedItem == 2 ? Colors.blue : Colors.white,
                        width: 2.0,
                      ),
                    ),
                    onTap: () {
                      _globalOnTap(2);
                    },
                    title: const Text("Notifications"),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
              child: BlocBuilder<SettingsWebCubit, SettingsWeb>(
                  builder: (context, state) {
                if (state is SettingsWebInitialState) {
                  return const AccountInfoWebView();
                }
                if (state is SettingsWebAccountInfo) {
                  return const AccountInfoWebView();
                }
                if (state is SettingsWebVerifyPassword) {
                  return const VerifyPasswordWeb();
                }
                if (state is SettingsWebChangeEmail) {
                  return const EmailUpdateWeb();
                } else {
                  return const AccountInfoWebView();
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  void _globalOnTap(index) {
    setState(() {
      selectedItem = index;
    });
  }
}
