import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates that the go back feature is enabled
/// for the provided index.
class WizardEnableGoBackEvent implements WizardEvent {
  /// Create a [WizardEnableGoBackEvent] event that indicates that the go back
  /// feature is enabled for the provided index.
  ///
  /// index: The index of the step that the go back feature is enabled for.
  const WizardEnableGoBackEvent({
    required this.index,
  });

  /// The index of the step that the go back feature is enabled for.
  final int index;
}
