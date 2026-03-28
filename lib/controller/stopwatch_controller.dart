import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchController extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  
  Duration _offset = Duration.zero; 
  
  final List<String> laps = [];
  bool get isRunning => _stopwatch.isRunning;
  
  int get totalMilliseconds => _stopwatch.elapsedMilliseconds + _offset.inMilliseconds;
  String get formattedTime => _formatTime(totalMilliseconds);

  void setCustomStart(int days, int hours, int minutes, int seconds) {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    _offset = Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
    laps.clear(); 
    notifyListeners();
  }

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
    _offset = Duration.zero; 
    laps.clear();
    notifyListeners();
  }

  void addLap() {
    if (_stopwatch.isRunning) {
      laps.insert(0, _formatTime(totalMilliseconds));
      notifyListeners();
    }
  }

  String _formatTime(int milliseconds) {
    // Itungan udeh support Hari
    int days = (milliseconds / (1000 * 60 * 60 * 24)).truncate();
    int hours = (milliseconds / (1000 * 60 * 60)).truncate() % 24;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int hundreds = (milliseconds / 10).truncate() % 100;

    String daysStr = days > 0 ? '${days} Hari ' : '';
    // Jam tetep muncul kalo harinya > 0 biar kaga rancu
    String hoursStr = (hours > 0 || days > 0) ? '${hours.toString().padLeft(2, '0')}:' : '';
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return "$daysStr$hoursStr$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}