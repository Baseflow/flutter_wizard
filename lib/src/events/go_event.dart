import '../../flutter_wizard.dart';

abstract class WizardGoEvent implements WizardEvent {
  int get fromIndex;
  int get toIndex;
}
