import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final controller = WizardController.of(context);
    return StreamBuilder<bool>(
      stream: controller.getIsGoNextEnabledStream(),
      initialData: controller.getIsGoNextEnabled(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }
        final enabled = snapshot.data!;
        return ElevatedButton(
          child: const Text("Next"),
          onPressed: enabled ? controller.next : null,
        );
      },
    );
  }
}
