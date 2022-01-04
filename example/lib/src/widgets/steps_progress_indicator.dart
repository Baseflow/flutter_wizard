import 'package:flutter/material.dart';

import '../../example.dart';

class StepsProgressIndicator extends StatelessWidget {
  const StepsProgressIndicator({
    Key? key,
    this.duration = const Duration(milliseconds: 150),
    required this.count,
    required this.index,
  })  : assert(index >= 0),
        assert(index < count),
        super(key: key);

  final Duration duration;
  final int count;
  final int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedLinearProgressIndicator(
      key: key,
      duration: duration,
      value: index / count,
    );
  }
}
