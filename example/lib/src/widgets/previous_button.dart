import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final controller = WizardController.of(context);
    return StreamBuilder<bool>(
      stream: controller.getIsGoBackEnabledStream(),
      initialData: controller.getIsGoBackEnabled(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        final enabled = snapshot.data!;
        return OutlinedButton(
          child: const Text("Previous"),
          onPressed: enabled ? controller.previous : null,
        );
      },
    );
  }
}
