import '../../flutter_wizard.dart';

class WizardDisableGoBackEvent implements WizardIndexEvent {
  const WizardDisableGoBackEvent({
    required this.index,
  });

  @override
  final int index;
}
