import 'package:flutter/material.dart';
import 'package:tweaxy/components/Test.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.tabController});
  final TabController tabController;

  final listitems = const [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
    'item14',
    'item15',
    'item16',
    'item18',
    'item19',
    'item20',
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
    'item14',
    'item15',
    'item16',
    'item18',
    'item19',
    'item20',
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
    'item14',
    'item15',
    'item16',
    'item18',
    'item19',
    'item20',
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
    'item14',
    'item15',
    'item16',
    'item18',
    'item19',
    'item20',
  ];
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ListView.builder(
          itemCount: listitems.length,
          itemBuilder: (context, index) {
            return Test();
          },
        ),
        ListView.builder(
          itemCount: listitems.length,
          itemBuilder: (context, index) {
            return Icon(Icons.directions_transit, size: 350);
          },
        ),
      ],
    );
  }
}