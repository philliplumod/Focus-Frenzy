import 'package:flutter/material.dart';
import 'package:focus_frenzy/timer/custom_long.dart';
import 'package:focus_frenzy/timer/custom_short.dart';
import 'package:focus_frenzy/timer/custom_pomododo.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({Key? key}) : super(key: key);

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xfff6abb6),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2),
        ),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 30,
              margin: const EdgeInsets.all(15.0),
              child: TabBar(
                controller: _tabController,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: const Color(0xfff4b6c2),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                tabs: const [
                  Tab(text: 'Pomodoro'),
                  Tab(text: 'Short Break'),
                  Tab(text: 'Long Break'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: CountDownPomodoro()),
                  Center(child: CountShortPomodoro()),
                  Center(child: CountLongPomodoro()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
