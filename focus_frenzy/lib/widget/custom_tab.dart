import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 30,
                margin: const EdgeInsets.all(15.0),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  labelColor: Colors.white,
                  indicatorColor: Colors.transparent,
                  //change tab color if selected
                  indicator: BoxDecoration(
                      color: Colors.black.withOpacity(.4),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  // unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Pomorodo'),
                    Tab(text: 'Short Break'),
                    Tab(text: 'Long Break'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('25:00')),
                    Center(child: Text('5:00')),
                    Center(child: Text('10:00')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
