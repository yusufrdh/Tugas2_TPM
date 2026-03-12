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
  
 
  final List<String> _laps = [];

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
    _laps.clear(); 
    setState(() {});
  }

  void _addLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch")),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24), 
            
            // --- LINGKARAN WAKTU ---
            Container(
              width: 260,
              height: 260,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [BoxShadow(color: const Color(0xFF4338CA).withOpacity(0.08), blurRadius: 30, spreadRadius: 5)],
                border: Border.all(color: const Color(0xFFE2E8F0), width: 2), 
              ),
              child: Text(
                _formatTime(_stopwatch.elapsedMilliseconds),
                style: const TextStyle(
                  fontSize: 52, 
                  fontWeight: FontWeight.w300, 
                  letterSpacing: 2, 
                  fontFeatures: [FontFeature.tabularFigures()], 
                  color: Color(0xFF4338CA)
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // --- AREA TOMBOL ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Reset (Kiri)
                _buildControlButton(
                  icon: Icons.refresh_rounded,
                  color: const Color(0xFF94A3B8), 
                  label: "Reset",
                  onPressed: _resetStopwatch,
                  isSecondary: true,
                ),
                const SizedBox(width: 24),
                
                // Tombol Start/Pause (Tengah - Utama)
                _buildControlButton(
                  icon: _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: const Color(0xFF4338CA), 
                  label: _stopwatch.isRunning ? "Pause" : "Start",
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                  isLarge: true, 
                ),
                const SizedBox(width: 24),
                
                // Tombol Lap (Kanan)
                _buildControlButton(
                  icon: Icons.flag_rounded,
                  color: const Color(0xFFF59E0B), 
                  label: "Lap",
                  onPressed: _addLap,
                  isSecondary: true,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // --- HEADER RIWAYAT LAP ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lap Records", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // --- LIST RIWAYAT LAP (Bisa di-scroll) ---
            Expanded(
              child: _laps.isEmpty 
                ? const Center(
                    child: Text("Belum ada lap tercatat.", style: TextStyle(color: Color(0xFF94A3B8)))
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _laps.length,
                    itemBuilder: (context, index) {

                      int lapNumber = _laps.length - index;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: const Color(0xFF1E293B).withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap $lapNumber", 
                              style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF64748B), fontSize: 15)
                            ),
                            Text(
                              _laps[index], 
                              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1E293B), fontSize: 16, fontFeatures: [FontFeature.tabularFigures()])
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required Color color, required VoidCallback onPressed, required String label, bool isSecondary = false, bool isLarge = false}) {
    double size = isLarge ? 80 : 64; 
    double iconSize = isLarge ? 36 : 28;

    return Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isSecondary ? Colors.white : color,
              shape: BoxShape.circle,
              border: isSecondary ? Border.all(color: const Color(0xFFE2E8F0), width: 2) : null,
              boxShadow: isSecondary ? [
                 BoxShadow(color: const Color(0xFF1E293B).withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))
              ] : [
                BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5)),
              ],
            ),
            child: Icon(icon, color: isSecondary ? color : Colors.white, size: iconSize),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSecondary ? const Color(0xFF64748B) : const Color(0xFF4338CA),
          ),
        ),
      ],
    );
  }
}