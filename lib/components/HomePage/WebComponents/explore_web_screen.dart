import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/WebComponents/search_bar_web.dart';

class ExploreWebScreen extends StatefulWidget {
  const ExploreWebScreen({super.key});

  @override
  State<ExploreWebScreen> createState() => _ExploreWebScreenState();
}

class _ExploreWebScreenState extends State<ExploreWebScreen> {
  String id = '';
  String token = '';
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('id')!;
      token = prefs.getString('token')!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SearchBarWeb(
              id: id,
              token: token,
            ),
          ),
        ],
      ),
    );
  }
}
