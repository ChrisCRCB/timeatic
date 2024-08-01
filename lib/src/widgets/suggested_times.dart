import 'package:flutter/material.dart';

import 'number_text.dart';

/// A list of suggested times.
class SuggestedTimes extends StatelessWidget {
  /// Create an instance.
  const SuggestedTimes({
    required this.onDone,
    super.key,
  });

  /// The function to call when a number is selected.
  final ValueChanged<int> onDone;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final items = [30, 45, 60, 90, 120, 300];
    return ListView.builder(
      itemBuilder: (final context, final index) {
        final n = items[index];
        return ListTile(
          autofocus: index == 0,
          title: NumberText(number: n),
          onTap: () => onDone(n),
        );
      },
      itemCount: items.length,
    );
  }
}
