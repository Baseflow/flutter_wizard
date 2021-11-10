import '../../flutter_wizard.dart';

class WizardDisableGoNextEvent implements WizardIndexEvent {
  const WizardDisableGoNextEvent({
    required this.index,
  });

  @override
  final int index;
}
