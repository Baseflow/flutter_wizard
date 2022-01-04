import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates navigation to the next [WizardStep].
class WizardGoNextEvent implements WizardGoEvent {
  /// Creates a [WizardGoNextEvent] event that indicates navigation to the next
  /// [WizardStep].
  ///
  /// fromIndex: The [WizardStep] index that the wizard is navigating away from.
  ///
  /// toIndex: The [WizardStep] index that the wizard is navigating to.
  const WizardGoNextEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
