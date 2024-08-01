import 'dart:async';

import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/number_text.dart';

/// A screen which counts down from [seconds].
class TimerScreen extends StatefulWidget {
  /// Create an instance.
  const TimerScreen({
    required this.seconds,
    super.key,
  });

  /// The total number of seconds to tick down from.
  final int seconds;

  /// Create state for this widget.
  @override
  TimerScreenState createState() => TimerScreenState();
}

/// State for [TimerScreen].
class TimerScreenState extends State<TimerScreen> {
  /// The current number of seconds.
  late int remainingSeconds;

  /// The timer to use.
  late final Timer timer;

  /// Whether the timer is paused.
  late bool paused;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.seconds;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (final timer) => tick(),
    );
    paused = false;
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => Cancel(
        child: SimpleScaffold(
          title: 'Timer',
          actions: [
            ElevatedButton(
              onPressed: () => setState(() => paused = !paused),
              child: Icon(
                paused ? Icons.play_arrow : Icons.pause,
                semanticLabel: paused ? 'Resume' : 'Pause',
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                remainingSeconds = widget.seconds;
              }),
              child: const Icon(
                Icons.replay,
                semanticLabel: 'Restart timer',
              ),
            ),
          ],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: NumberText(number: remainingSeconds),
              ),
            ],
          ),
        ),
      );

  /// Tick the timer.
  void tick() {
    if (remainingSeconds <= 0 || paused) {
      return;
    }
    remainingSeconds--;
    if (remainingSeconds == 0) {
      HapticFeedback.vibrate();
    } else if ((remainingSeconds % 10) == 0) {
      HapticFeedback.vibrate();
    } else if ((remainingSeconds % 5) == 0) {
      HapticFeedback.lightImpact();
    } else if (remainingSeconds <= 10) {
      HapticFeedback.selectionClick();
    }
    setState(() {});
  }
}
