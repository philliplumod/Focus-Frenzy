import 'package:flutter/material.dart';
import 'package:focus_frenzy/widget/custom_tab.dart';

// Colors
// #f07241
// #c04848
// #601848

class FocusFrenzy extends StatelessWidget {
  const FocusFrenzy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Focus Frenzy'),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: CustomTab(),
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(240, 114, 65, 1),
    );
  }
}
