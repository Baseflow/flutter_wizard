import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates navigation to the previous
/// [WizardStep].
class WizardGoBackEvent implements WizardGoEvent {
  /// Creates a [WizardGoBackEvent] event that indicates navigation to the
  /// previous [WizardStep].
  ///
  /// fromIndex: The [WizardStep] index that the wizard is navigating away from.
  ///
  /// toIndex: The [WizardStep] index that the wizard is navigating to.
  const WizardGoBackEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
