import 'package:flutter/material.dart';

import '../../example.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.label,
    required this.input,
  }) : super(key: key);

  final Widget label;
  final Widget input;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle.merge(
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            child: label,
          ),
          const SizedBox(height: kSmallPadding),
          input,
        ],
      ),
    );
  }
}
