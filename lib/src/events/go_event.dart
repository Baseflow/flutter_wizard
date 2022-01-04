import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates navigation from one [WizardStep] to
/// another.
abstract class WizardGoEvent implements WizardEvent {
  /// The [WizardStep] index that the wizard is navigating away from.
  int get fromIndex;

  /// The [WizardStep] index that the wizard is navigating to.
  int get toIndex;
}
