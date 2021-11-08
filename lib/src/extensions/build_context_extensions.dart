import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';

extension FlutterWizardBuildContextX on BuildContext {
  WizardController get wizardController {
    return WizardController.of(this);
  }
}
