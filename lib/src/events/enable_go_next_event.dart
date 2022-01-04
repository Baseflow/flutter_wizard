import '../../flutter_wizard.dart';

/// A [WizardEvent] event that indicates that the go next feature is enabled
/// for the provided index.
class WizardEnableGoNextEvent implements WizardEvent {
  /// Create a [WizardEnableGoNextEvent] event that indicates that the go next
  /// feature is enabled for the provided index.
  ///
  /// index: The index of the step that the go next feature is enabled for.
  const WizardEnableGoNextEvent({
    required this.index,
  });

  /// The index of the page that the go next feature is enabled for.
  final int index;
}
