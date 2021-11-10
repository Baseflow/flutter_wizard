import '../../flutter_wizard.dart';

class WizardGoBackEvent implements WizardGoEvent {
  const WizardGoBackEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
