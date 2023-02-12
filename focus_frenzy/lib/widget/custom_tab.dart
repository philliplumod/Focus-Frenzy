import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: const [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    //change tab color if selected
                    indicator: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    // unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Pomorodo'),
                      Tab(text: 'Short Break'),
                      Tab(text: 'Long Break'),
                    ],
                  ),
                ),
              ),
              Expanded(
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
