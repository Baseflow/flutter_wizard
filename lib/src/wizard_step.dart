import '../flutter_wizard.dart';

abstract class WizardStep {
  WizardStep();

  /// The field used to store the wizard controller.
  late WizardController _wizardController;

  /// Getter for the wizard controller.
  WizardController get wizardController => _wizardController;

  /// Setter for the wizard controller. When set the [onControllerReceived]
  /// event will be fired.
  set wizardController(
    WizardController wizardController,
  ) {
    _wizardController = wizardController;
    onControllerReceived();
  }

  /// Event which fires when the [wizardController] has been set.
  Future<void> onControllerReceived() async {}

  /// Triggered when step has started showing.
  Future<void> onShowing() async {}

  /// Triggered when step has completed showing.
  Future<void> onShowingCompleted() async {}

  /// Triggered when step has started hiding.
  Future<void> onHiding() async {}

  /// Triggered when step has completed hiding.
  Future<void> onHidingCompleted() async {}
}
