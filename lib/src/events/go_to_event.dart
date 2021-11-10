import '../../flutter_wizard.dart';

class WizardGoToEvent implements WizardGoEvent {
  const WizardGoToEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
