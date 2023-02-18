import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class CountDownPomodoro extends StatefulWidget {
  const CountDownPomodoro({Key? key}) : super(key: key);

  @override
  State<CountDownPomodoro> createState() => _CountDownPomodoroState();
}

class _CountDownPomodoroState extends State<CountDownPomodoro> {
  bool _isRunning = false;
  late bool isSuccess = false;
  final CountdownController _controller = CountdownController();
  final audioCache = AudioCache();

  @override
  void initState() {
    super.initState();
    audioCache.load('ring_bell.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Countdown(
          controller: _controller,
          seconds: 1 * 3,
          build: (BuildContext context, double time) => Text(
            formatDuration(Duration(seconds: time.toInt())),
            style: const TextStyle(fontSize: 40, color: Colors.black),
          ),
          interval: const Duration(milliseconds: 100),
          onFinished: () async {
            isSuccess = true;
            setState(() {
              _isRunning = false;
            });
            _controller.pause();

            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color(0xfff6abb6),
                  title: const Text(
                    'Time is up!',
                  ),
                  content: const Text(
                    'Your timer has finished.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _controller.restart();
                        _controller.pause();
                      },
                      child: const Text('OK',
                          style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pop();
                            _controller.start();
                            _controller.restart();
                            _isRunning = true;
                          });
                        },
                        child: const Text('Restart',
                            style: TextStyle(color: Colors.black)))
                  ],
                );
              },
            );
            if (isSuccess) {
              await Vibration.hasVibrator();
              await audioCache.play('ring_bell.mp3');
              Vibration.vibrate();
            }
          },
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 0),
                  backgroundColor: Colors.black,
                  foregroundColor: const Color(0xfff6abb6),
                  elevation: 0),
              child: Text(
                _isRunning ? 'Stop' : 'Start',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  if (_isRunning) {
                    _controller.pause();
                    _isRunning = false;
                  } else {
                    _controller.start();
                    _isRunning = true;
                  }
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 0),
                  backgroundColor: Colors.black,
                  foregroundColor: const Color(0xfff6abb6),
                  elevation: 0),
              child: const Text(
                'Reset',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  _controller.restart();
                  _controller.pause();
                  _isRunning = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
