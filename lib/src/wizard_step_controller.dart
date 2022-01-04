import 'package:rxdart/rxdart.dart';

import '../flutter_wizard.dart';

/// Coordinates the wizard steps and its input control states.
abstract class WizardStepController {
  /// Coordinates the wizard steps and its input control states.
  ///
  /// step: The wizard step which can contain ever state management solution
  /// that you wish. A provider, bloc, etc can be provided in this property.
  ///
  /// initialIsBackEnabled: Indicates if the back button will be enabled on the
  /// initial load.
  ///
  /// initialIsNextEnabled: Indicates if the previous button will be enabled on
  /// the initial load.
  factory WizardStepController({
    required WizardStep step,
    bool isBackEnabled = true,
    bool isNextEnabled = true,
  }) {
    return WizardStepControllerImpl(
      step: step,
      isBackEnabled: isBackEnabled,
      isNextEnabled: isNextEnabled,
    );
  }

  /// Wizard step which can contain ever state management solution that you
  /// wish. A provider, bloc, etc can be provided in this property.
  WizardStep get step;

  /// Streams whether the back button is enabled
  Stream<bool> get isGoBackEnabledStream;

  /// Indicates whether the back button currently is enabled
  bool get isGoBackEnabled;

  /// Enable the previous button
  void enableGoBack();

  /// Disable the previous button
  void disableGoBack();

  /// Stream whether the next button is enabled
  Stream<bool> get isGoNextEnabledStream;

  /// Indicates whether the next button currently is enabled
  bool get isGoNextEnabled;

  /// Enable the next button
  void enableGoNext();

  /// Disable the next button
  void disableGoNext();

  /// Dispose the controller
  void dispose();
}

/// Coordinates the wizard steps and its input control states.
///
/// The default implementation of the [WizardStepController].
class WizardStepControllerImpl implements WizardStepController {
  /// Coordinates the wizard steps and its input control states.
  ///
  /// step: The wizard step which can contain ever state management solution
  /// that you wish. A provider, bloc, etc can be provided in this property.
  ///
  /// initialIsBackEnabled: Indicates if the back button will be enabled on the
  /// initial load.
  ///
  /// initialIsNextEnabled: Indicates if the previous button will be enabled on
  /// the initial load.
  WizardStepControllerImpl({
    required this.step,
    bool isBackEnabled = true,
    bool isNextEnabled = true,
  })  : _isBackEnabled = BehaviorSubject<bool>.seeded(
          isBackEnabled,
        ),
        _isNextEnabled = BehaviorSubject<bool>.seeded(
          isNextEnabled,
        );

  final BehaviorSubject<bool> _isBackEnabled;
  final BehaviorSubject<bool> _isNextEnabled;

  @override
  final WizardStep step;

  @override
  Stream<bool> get isGoBackEnabledStream {
    return _isBackEnabled.stream.asBroadcastStream().distinct();
  }

  @override
  bool get isGoBackEnabled {
    return _isBackEnabled.value;
  }

  @override
  Stream<bool> get isGoNextEnabledStream {
    return _isNextEnabled.stream.asBroadcastStream().distinct();
  }

  @override
  bool get isGoNextEnabled {
    return _isNextEnabled.value;
  }

  @override
  void enableGoBack() => _isBackEnabled.add(true);

  @override
  void disableGoBack() => _isBackEnabled.add(false);

  @override
  void enableGoNext() => _isNextEnabled.add(true);

  @override
  void disableGoNext() => _isNextEnabled.add(false);

  @override
  void dispose() {
    _isBackEnabled.close();
    _isNextEnabled.close();
  }
}
