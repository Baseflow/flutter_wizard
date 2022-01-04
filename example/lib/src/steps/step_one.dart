import 'package:flutter/material.dart';

import '../../example.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    required this.provider,
    Key? key,
  }) : super(key: key);

  final StepOneProvider provider;

  @override
  Widget build(
    BuildContext context,
  ) {
    return InputField(
      label: const Text(
        'Description',
      ),
      input: TextField(
        controller: provider.descriptionTextController,
        onChanged: (_) => provider.updateDescription(
          provider.descriptionTextController.text,
        ),
        focusNode: provider.descriptionFocusNode,
      ),
    );
  }
}
