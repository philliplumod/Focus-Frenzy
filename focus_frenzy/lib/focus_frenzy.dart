import 'package:flutter/material.dart';
import 'package:focus_frenzy/widget/custom_tab.dart';

// Colors
// #f07241
// #c04848
// #601848

class FocusFrenzy extends StatefulWidget {
  final Function? startStopTimer;

  const FocusFrenzy({super.key, this.startStopTimer});

  @override
  State<FocusFrenzy> createState() => _FocusFrenzyState();
}

class _FocusFrenzyState extends State<FocusFrenzy> {
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
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(240, 114, 65, 1),
    );
  }
}

// class CustomTimer extends StatefulWidget {
//   const CustomTimer({super.key});

//   @override
//   State<CustomTimer> createState() => _CustomTimerState();
// }

// class _CustomTimerState extends State<CustomTimer> {
//   int _minutes = 0;
//   int _seconds = 0;
//   bool _isRunning = false;
//   Timer? _timer;

//   int get minutes => _minutes;

//   void startStopTimer() {
//     setState(() {
//       _isRunning = !_isRunning;
//     });

//     if (_isRunning) {
//       _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         setState(() {
//           if (_seconds == 0 && _minutes == 0) {
//             timer.cancel();
//             _isRunning = false;
//           } else if (_seconds == 0) {
//             _minutes--;
//             _seconds = 59;
//           } else {
//             _seconds--;
//           }
//         });
//       });
//     } else {
//       _timer?.cancel();
//     }
//   }

//   void _resetTimer() {
//     _timer?.cancel();
//     setState(() {
//       _minutes = 0;
//       _seconds = 0;
//       _isRunning = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           "$_minutes : $_seconds",
//           style: const TextStyle(
//               fontSize: 50, fontWeight: FontWeight.w100, color: Colors.white),
//         )
//       ],
//     );
//   }
// }
