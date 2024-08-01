import 'dart:math';

import 'package:backstreets_widgets/extensions.dart';
import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';

import '../widgets/number_button.dart';
import '../widgets/number_text.dart';
import '../widgets/suggested_times.dart';
import 'timer_screen.dart';

/// A screen to set the time.
class SetTimeScreen extends StatefulWidget {
  /// Create an instance.
  const SetTimeScreen({
    this.minValue = 1,
    super.key,
  });

  /// The minimum possible value.
  final int minValue;

  /// Create state for this widget.
  @override
  SetTimeScreenState createState() => SetTimeScreenState();
}

/// State for [SetTimeScreen].
class SetTimeScreenState extends State<SetTimeScreen> {
  /// The number of seconds.
  late int seconds;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    seconds = 45;
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final minus10 = NumberButton(number: -10, onPressed: updateSeconds);
    final minus1 = NumberButton(number: -1, onPressed: updateSeconds);
    final plus1 = NumberButton(number: 1, onPressed: updateSeconds);
    final plus10 = NumberButton(number: 10, onPressed: updateSeconds);
    final minusColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        minus1,
        minus10,
      ],
    );
    final plusColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        plus1,
        plus10,
      ],
    );
    return SimpleScaffold(
      title: 'Set Time',
      body: OrientationBuilder(
        builder: (final context, final orientation) {
          switch (orientation) {
            case Orientation.portrait:
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: SuggestedTimes(
                      onDone: (final value) => context.pushWidgetBuilder(
                        (final context) => TimerScreen(seconds: value),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: NumberText(number: seconds),
                    ),
                  ),
                  Row(
                    children: [
                      minusColumn,
                      plusColumn,
                    ],
                  ),
                ],
              );
            case Orientation.landscape:
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SuggestedTimes(
                      onDone: (final value) => context.pushWidgetBuilder(
                        (final context) => TimerScreen(seconds: value),
                      ),
                    ),
                  ),
                  minusColumn,
                  Expanded(
                    flex: 3,
                    child: NumberText(number: seconds),
                  ),
                  plusColumn,
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushWidgetBuilder(
          (final context) => TimerScreen(seconds: seconds),
        ),
        child: const Icon(
          Icons.play_arrow,
          semanticLabel: 'Start timer',
        ),
      ),
    );
  }

  /// Update the [seconds] value.
  void updateSeconds(final int modifiers) {
    setState(() {
      seconds = max(widget.minValue, seconds + modifiers);
    });
  }
}
