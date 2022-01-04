import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates forced navigation from one [WizardStep]
/// back to another.
///
/// This event will be triggered when one of the [WizardStep]s earlier on in
/// line are being disabled.
class WizardForcedGoBackToEvent implements WizardGoEvent {
  /// Creates a [WizardForcedGoBackToEvent] event that indicates forced navigation from one [WizardStep]
  /// back to another.
  ///
  /// fromIndex: The [WizardStep] index that the wizard is navigating away from.
  ///
  /// toIndex: The [WizardStep] index that the wizard is navigating to.
  const WizardForcedGoBackToEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
