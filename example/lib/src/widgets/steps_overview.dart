import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

import '../../example.dart';

class StepsOverview extends StatelessWidget {
  const StepsOverview({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: context.wizardController.stepControllers.length,
      itemBuilder: (context, index) {
        final step = context.wizardController.stepControllers[index].step;
        return StreamBuilder<bool>(
          stream: context.wizardController.getIsGoToEnabledStream(index),
          initialData: context.wizardController.getIsGoToEnabled(index),
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
              stream: context.wizardController.indexStream,
              initialData: context.wizardController.index,
              builder: (context, snapshot) {
                final selectedIndex = snapshot.data!;
                return ListTile(
                  title: Text(title),
                  onTap: enabled
                      ? () => context.wizardController.goTo(index: index)
                      : null,
                  enabled: enabled,
                  selected: index == selectedIndex,
                );
              },
            );
          },
        );
      },
    );
  }
}
