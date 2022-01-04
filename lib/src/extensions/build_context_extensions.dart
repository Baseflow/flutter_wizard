import 'package:flutter/material.dart';

import '../../flutter_wizard.dart';

/// Extensions for the [BuildContext] class.
extension FlutterWizardBuildContextX on BuildContext {
  /// The closest instance of the [WizardController] class that encloses the
  /// given context.
  ///
  /// {@tool snippet}
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WizardController controller = context.wizardController;
  /// ```
  /// {@end-tool}
  WizardController get wizardController {
    return WizardController.of(this);
  }
}
