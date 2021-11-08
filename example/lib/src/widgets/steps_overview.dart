import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

import '../barrel.dart';

class StepsOverview extends StatelessWidget {
  const StepsOverview({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final controller = WizardController.of(context);
    return ListView.builder(
      itemCount: controller.stepControllers.length,
      itemBuilder: (context, index) {
        final step = controller.stepControllers[index].step;
        return StreamBuilder<bool>(
          stream: controller.getIsAnimateToEnabledStream(index),
          initialData: controller.getIsAnimateToEnabled(index),
          builder: (context, snapshot) {
            final enabled = snapshot.data!;
            String title;
            switch (step.runtimeType) {
              case StepOneProvider:
                title = "Step one";
                break;
              case StepTwoProvider:
                title = "Step two";
                break;
              case StepThreeProvider:
                title = "Step Three";
                break;
              default:
                title = "Unknown step description";
                break;
            }
            return StreamBuilder<int>(
                stream: controller.indexStream,
                initialData: controller.index,
                builder: (context, snapshot) {
                  final selectedIndex = snapshot.data!;
                  return ListTile(
                    title: Text(title),
                    onTap: enabled
                        ? () => controller.animateTo(index: index)
                        : null,
                    enabled: enabled,
                    selected: index == selectedIndex,
                  );
                });
          },
        );
      },
    );
  }
}
