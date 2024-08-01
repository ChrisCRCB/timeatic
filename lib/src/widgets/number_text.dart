import 'package:flutter/material.dart';

/// A [Text] widget which shows [number].
class NumberText extends StatelessWidget {
  /// Create an instance.
  const NumberText({
    required this.number,
    super.key,
  });

  /// The number to show.
  final int number;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final String data;
    if (number < 60) {
      data = '$number ${number == 1 ? "second" : "seconds"}';
    } else {
      final minutes = (number / 60).floor();
      final seconds = number - (minutes * 60);
      final minutesString = minutes.toString().padLeft(2, '0');
      final secondsString = seconds.toString().padLeft(2, '0');
      data = '$minutesString:$secondsString';
    }
    return Semantics(
      liveRegion: true,
      child: Text(
        data,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
