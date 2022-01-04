import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates that the go next feature is disabled
/// for the provided index.
class WizardDisableGoNextEvent implements WizardEvent {
  /// Create a [WizardDisableGoNextEvent] event that indicates that the go next
  /// feature is disabled for the provided index.
  ///
  /// index: The index of the step that the go next feature is disabled for.
  const WizardDisableGoNextEvent({
    required this.index,
  });

  /// The index of the step that the go next feature is disabled for.
  final int index;
}
