import 'package:flutter/material.dart';

import 'step_three_provider.dart';

class StepThree extends StatelessWidget {
  const StepThree({
    required this.provider,
    Key? key,
  }) : super(key: key);

  final StepThreeProvider provider;

  @override
  Widget build(
    BuildContext context,
  ) {
    return const Center(
      child: Text(
        'Confirmation text',
      ),
    );
  }
}
