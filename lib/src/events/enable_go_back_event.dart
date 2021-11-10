import '../../flutter_wizard.dart';

class WizardEnableGoBackEvent implements WizardIndexEvent {
  const WizardEnableGoBackEvent({
    required this.index,
  });

  @override
  final int index;
}
