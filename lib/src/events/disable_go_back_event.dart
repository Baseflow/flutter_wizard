import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates that the go back feature is disabled
/// for the provided index.
class WizardDisableGoBackEvent implements WizardEvent {
  /// Create a [WizardDisableGoBackEvent] event that indicates that the go back
  /// feature is disabled for the provided index.
  ///
  /// index: The index of the step that the go back feature is disabled for.
  const WizardDisableGoBackEvent({
    required this.index,
  });

  /// The index of the step that the go back feature is disabled for.
  final int index;
}
