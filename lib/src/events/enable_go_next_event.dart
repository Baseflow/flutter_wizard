import '../../flutter_wizard.dart';

class WizardEnableGoNextEvent implements WizardIndexEvent {
  const WizardEnableGoNextEvent({
    required this.index,
  });

  @override
  final int index;
}
