import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountDownPomodoro extends StatefulWidget {
  const CountDownPomodoro({super.key});

  @override
  State<CountDownPomodoro> createState() => _CountDownPomodoroState();
}

class _CountDownPomodoroState extends State<CountDownPomodoro> {
  final CountdownController _controller = CountdownController();

  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Countdown(
          controller: _controller,
          seconds: 25 * 60,
          build: (BuildContext context, double time) => Text(
            formatDuration(Duration(seconds: time.toInt())),
            style: const TextStyle(fontSize: 40, color: Colors.black),
          ),
          interval: const Duration(milliseconds: 100),
          onFinished: () async {
            setState(() {
              _isRunning = false;
            });
            _controller.pause();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  title: const Text(
                    'Time is up!',
                    style: TextStyle(color: Color.fromRGBO(241, 196, 15, 1)),
                  ),
                  content: const Text(
                    'Your timer has finished.',
                    style: TextStyle(color: Color.fromRGBO(241, 196, 15, 1)),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _controller.restart();
                        _controller.pause();
                      },
                      child: const Text('OK',
                          style: TextStyle(
                              color: Color.fromRGBO(241, 196, 15, 1))),
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
                            style: TextStyle(
                                color: Color.fromRGBO(241, 196, 15, 1))))
                  ],
                );
              },
            );
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
                  foregroundColor: const Color.fromRGBO(241, 196, 15, 1),
                  elevation: 0),
              child: Text(
                _isRunning ? 'Stop' : 'Start',
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
                  foregroundColor: const Color.fromRGBO(241, 196, 15, 1),
                  elevation: 0),
              child: const Text('Reset'),
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
