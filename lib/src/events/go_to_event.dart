import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates navigation to a specific [WizardStep].
class WizardGoToEvent implements WizardGoEvent {
  /// Creates a [WizardGoToEvent] event that indicates navigation to a specific
  /// [WizardStep].
  ///
  /// fromIndex: The [WizardStep] index that the wizard is navigating away from.
  ///
  /// toIndex: The [WizardStep] index that the wizard is navigating to.
  const WizardGoToEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
