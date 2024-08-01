import 'package:flutter/material.dart';

/// A button which sends a [number].
class NumberButton extends StatelessWidget {
  /// Create an instance.
  const NumberButton({
    required this.number,
    required this.onPressed,
    super.key,
  });

  /// The number to send.
  final int number;

  /// THe function to call with [number].
  final ValueChanged<int> onPressed;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => TextButton(
        onPressed: () => onPressed(number),
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      );
}
