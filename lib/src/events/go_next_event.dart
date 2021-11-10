import '../../flutter_wizard.dart';

class WizardGoNextEvent implements WizardGoEvent {
  const WizardGoNextEvent({
    required this.fromIndex,
    required this.toIndex,
  });

  @override
  final int fromIndex;

  @override
  final int toIndex;
}
