import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:audioplayers/audioplayers.dart';

class CountShortPomodoro extends StatefulWidget {
  const CountShortPomodoro({super.key});

  @override
  State<CountShortPomodoro> createState() => _CountShortPomodoroState();
}

class _CountShortPomodoroState extends State<CountShortPomodoro> {
  final CountdownController _controller = CountdownController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setSourceAsset('assets/ring_bell.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Countdown(
          controller: _controller,
          seconds: 5 * 60,
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
            await _audioPlayer.play(UrlSource('assets/ring_bell.mp3'));
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
