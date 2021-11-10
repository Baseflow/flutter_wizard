import '../../flutter_wizard.dart';

class WizardForcedGoBackToEvent implements WizardGoEvent {
  const WizardForcedGoBackToEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
