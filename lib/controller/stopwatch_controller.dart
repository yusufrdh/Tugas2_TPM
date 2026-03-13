import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchController extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  
  final List<String> laps = [];
  bool get isRunning => _stopwatch.isRunning;
  String get formattedTime => _formatTime(_stopwatch.elapsedMilliseconds);

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        notifyListeners();
      });
    }
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      notifyListeners();
    }
  }

  void reset() {
    _stopwatch.reset();
    laps.clear();
    notifyListeners();
  }

  void addLap() {
    if (_stopwatch.isRunning) {
      laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
      notifyListeners();
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}