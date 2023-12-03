import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/views/settings/web/dialog_verify_password.dart';

class EmailUpdateWeb extends StatefulWidget {
  const EmailUpdateWeb({super.key});

  @override
  State<EmailUpdateWeb> createState() => _EmailUpdateWebState();
}

List<String> emailList = [];

class _EmailUpdateWebState extends State<EmailUpdateWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<SettingsWebCubit>(context).toggleMenu(2);
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
            "Change  email",
            textAlign: TextAlign.left),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (emailList.isNotEmpty)
              ListView.builder(
                  itemCount: emailList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.grey[500],
                      title: Text(
                        "current",
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      subtitle: Text(
                        emailList[index],
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    );
                  }),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .02),
              child: Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const DialogVerifyPassword(),
                      barrierColor: const Color.fromARGB(100, 97, 119, 129),
                    );
                  },
                  child: const Text(
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.lightBlue,
                      ),
                      "Update email address",
                      textAlign: TextAlign.center),
                ),
              ),
            )
          ]),
    );
  }
}
