import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/models/trend.dart';
import 'package:tweaxy/services/get_trends.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({Key? key}) : super(key: key);

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  @override
  void initState() {
    super.initState();
    _getTrends();
  }

  final GetTrendsService services = GetTrendsService(dio: Dio());

  List<Trend> trends = [];

  _getTrends() async {
    final List<Trend> newItems =
        await services.getTrendsList(null, limit: 5, pageNumber: 0);
    trends = newItems;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SidebarCubit(),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: screenHeight * 0.65,
          decoration: BoxDecoration(
              color: const Color(0xfff7f9f9),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(screenWidth * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.009,
                    right: screenWidth * 0.009,
                    top: screenWidth * 0.009),
                child: const Text(
                  'What\'s happening',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trends.length,
                itemBuilder: (BuildContext context, int index) {
                  String s = trends[index].count > 1 ? ' posts' : ' post';
                  var postNumber =
                      NumberFormat.compactCurrency(symbol: '', decimalDigits: 0)
                          .format(trends[index].count);
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.01),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        '${index + 1} . Trending',
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              '#${trends[index].name}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '$postNumber$s',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              // fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<SidebarCubit>(context).openExplore();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.009,
                      right: screenWidth * 0.009,
                      top: screenWidth * 0.009),
                  child: const Text(
                    'Show more',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
