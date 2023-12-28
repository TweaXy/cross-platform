import 'package:flutter/material.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class CustomAppbarWeb extends StatelessWidget {
  const CustomAppbarWeb({super.key, required this.icon, this.pageNumber});
  final String? pageNumber;
  final IconButton? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 25),
      alignment: Alignment.topLeft,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: [
          icon ?? const SizedBox(),
          Text(
            pageNumber == null ? "" : "Step $pageNumber of 4",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: forgroundColorTheme(context),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
