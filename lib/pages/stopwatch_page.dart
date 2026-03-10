import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});
  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    if (_stopwatch.isRunning) _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _startTimer();
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
      setState(() {});
    }
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 280,
              height: 280,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  // Shadow disesuaikan jadi warna indigo yang sangat soft
                  BoxShadow(color: const Color(0xFF4338CA).withOpacity(0.08), blurRadius: 30, spreadRadius: 5),
                ],
                border: Border.all(color: const Color(0xFFE2E8F0), width: 2), // Border abu-abu kebiruan
              ),
              child: Text(
                _formatTime(_stopwatch.elapsedMilliseconds),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                  fontFeatures: [FontFeature.tabularFigures()],
                  color: Color(0xFF4338CA), // Angka jadi Tech Indigo biar senada!
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: const Color(0xFF4338CA), // Tombol utama warna Tech Indigo
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                ),
                const SizedBox(width: 24),
                _buildControlButton(
                  icon: Icons.stop_rounded,
                  color: const Color(0xFF94A3B8), // Tombol sekunder (stop) warna abu-abu kalem
                  onPressed: _resetStopwatch,
                  isSecondary: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onPressed, bool isSecondary = false}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSecondary ? Colors.white : color,
          shape: BoxShape.circle,
          border: isSecondary ? Border.all(color: const Color(0xFFE2E8F0), width: 2) : null,
          boxShadow: isSecondary ? [
             // Shadow tipis untuk tombol sekunder
             BoxShadow(color: const Color(0xFF1E293B).withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))
          ] : [
            // Shadow nyala untuk tombol utama
            BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Icon(icon, color: isSecondary ? color : Colors.white, size: 32),
      ),
    );
  }
}