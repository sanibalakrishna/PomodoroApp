import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

AudioPlayer audioPlayer = AudioPlayer();
Future<void> playSound() async {
  ByteData soundData = await rootBundle.load('assets/sounds/sound.mp3');
  await audioPlayer.playBytes(soundData.buffer.asUint8List());
}

Future<void> playShort() async {
  ByteData soundData = await rootBundle.load('assets/sounds/short.mp3');
  await audioPlayer.playBytes(soundData.buffer.asUint8List());
}

Future<void> playLong() async {
  ByteData soundData = await rootBundle.load('assets/sounds/long.mp3');
  await audioPlayer.playBytes(soundData.buffer.asUint8List());
}

class PomodoroTimer extends StatefulWidget {
  final String title;
  final int modetime;
  final Function() updateCount;
  final int count;
  final Function(String) changeMode;
  const PomodoroTimer(
      {required this.title,
      required this.modetime,
      required this.updateCount,
      required this.changeMode,
      required this.count});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late Timer _timer;
  bool _isRunning = false;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.modetime;
  }

  @override
  void didUpdateWidget(covariant PomodoroTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _secondsRemaining = widget.modetime;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          if (widget.title == "Focus") {
            widget.updateCount();
            if (widget.count % 4 == 0 && widget.count != 0) {
              playLong();
              widget.changeMode("Long");
            } else {
              playShort();
              widget.changeMode("Short");
            }
          } else {
            playSound();
            widget.changeMode("Focus");
          }
          _isRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _isRunning = false;
      _secondsRemaining = widget.modetime;
    });
  }

  void _onToggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
    if (_isRunning) {
      _startTimer();
    } else {
      _pauseTimer();
    }
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Text(
          _formatDuration(Duration(seconds: _secondsRemaining)),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 32),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: CircularProgressIndicator(
                value: _secondsRemaining / (widget.modetime),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 161, 247, 164)),
                strokeWidth: 15,
                semanticsValue: 10.toString(),
              ),
            ),
            IconButton(
              onPressed: _onToggleTimer,
              iconSize: 64,
              icon: Icon(
                _isRunning ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _resetTimer,
              child: Text('Reset'),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(100, 40)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 249, 140, 140))),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
}
