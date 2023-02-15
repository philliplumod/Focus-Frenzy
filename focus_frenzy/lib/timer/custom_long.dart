import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountLongPomodoro extends StatefulWidget {
  const CountLongPomodoro({super.key});

  @override
  State<CountLongPomodoro> createState() => _CountLongPomodoroState();
}

class _CountLongPomodoroState extends State<CountLongPomodoro> {
  final CountdownController _controller = CountdownController();
  bool _isRunning = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  //buzzer
  Future<void> _loadSound() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.stop);
    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.setSourceAsset('assets/sounds/buzzer.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Countdown(
          controller: _controller,
          seconds: 10 * 60,
          build: (BuildContext context, double time) => Text(
            formatDuration(Duration(seconds: time.toInt())),
            style: const TextStyle(fontSize: 40, color: Colors.black),
          ),
          interval: const Duration(milliseconds: 100),
          onFinished: () {
            setState(() {
              _isRunning = false;
            });
            _controller.restart();
            _loadSound();
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
