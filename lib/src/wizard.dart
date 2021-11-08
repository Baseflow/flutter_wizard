import 'dart:async';

import 'package:flutter/material.dart';

import '../flutter_wizard.dart';

/// Signature for building the [Wizard] steps.
typedef WizardStepBuilder = Widget Function(
  BuildContext context,
  WizardStep step,
);

/// Signature for builder with [BuildContext] and [WizardController] arguments.
typedef WizardBuilder = Widget Function(
  BuildContext context,
  WizardController controller,
);

/// Signature for building the [Wizard] buttons.
typedef WizardButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback? onPressed,
);
typedef StepCallback = FutureOr<void> Function(int oldIndex, int index);

/// A widget to create a multi-step wizard with separated state files.
class Wizard extends StatelessWidget {
  const Wizard({
    required this.stepBuilder,
    Key? key,
  }) : super(key: key);

  /// The builder method to build the steps corresponding widget. The builder
  /// method provides the [BuildContext] and [WizardStepState]. The state can
  /// then be used to determine how to build the view.
  ///
  /// Example:
  /// ```dart
  /// stepBuilder: (context, state) {
  ///   if (state is StepOneProvider) {
  ///     return StepOne(
  ///       provider: state,
  ///     );
  ///   }
  ///   if (state is StepTwoProvider) {
  ///     return StepTwo(
  ///       provider: state,
  ///     );
  ///   }
  ///   return Container();
  /// },
  /// ```
  final WizardStepBuilder stepBuilder;

  @protected
  @override
  Widget build(
    BuildContext context,
  ) {
    return PageView.builder(
      controller: context.wizardController.pageController,
      itemCount: context.wizardController.stepControllers.length,
      itemBuilder: (context, index) {
        return stepBuilder(
          context,
          context.wizardController.stepControllers[index].step,
        );
      },
      // TODO: Improve
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
