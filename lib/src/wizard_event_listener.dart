import 'dart:async';

import 'package:flutter/widgets.dart';

import '../flutter_wizard.dart';

/// Signature for [WizardEvent] callbacks with [BuildContext] and [WizardEvent].
typedef WizardEventCallback = FutureOr<void> Function(
  BuildContext context,
  WizardEvent event,
);

/// An event listener that can be used to listen to [WizardEvent]s of the
/// [Wizard].
///
/// Possible events are:
/// - [WizardEnableGoBackEvent]: Triggered when `enableGoBack` is called.
/// - [WizardEnableGoNextEvent]: Triggered when `enableGoNext` is called.
/// - [WizardDisableGoBackEvent]: Triggered when `disableGoBack` is called.
/// - [WizardDisableGoNextEvent]: Triggered when `disableGoNext` is called.
/// - [WizardGoNextEvent]: Triggered when `goNext` is called.
/// - [WizardGoBackEvent]: Triggered when `goBack` is called.
/// - [WizardGoToEvent]: Triggered when `goTo` is called.
/// - [WizardForcedGoBackToEvent]: Triggered when `disableGoNext` is called
/// with an index lower as the current index.
class WizardEventListener extends StatefulWidget {
  /// Creates an [WizardEventListener] which provide a listener that can be used
  /// to listen to [WizardEvent]s of the [Wizard].
  ///
  /// Possible [WizardEvent]s are:
  /// - [WizardEnableGoBackEvent]: Triggered when `enableGoBack` is called.
  /// - [WizardEnableGoNextEvent]: Triggered when `enableGoNext` is called.
  /// - [WizardDisableGoBackEvent]: Triggered when `disableGoBack` is called.
  /// - [WizardDisableGoNextEvent]: Triggered when `disableGoNext` is called.
  /// - [WizardGoNextEvent]: Triggered when `goNext` is called.
  /// - [WizardGoBackEvent]: Triggered when `goBack` is called.
  /// - [WizardGoToEvent]: Triggered when `goTo` is called.
  /// - [WizardForcedGoBackToEvent]: Triggered when `disableGoNext` is called
  /// with an index lower as the current index.
  const WizardEventListener({
    Key? key,
    required this.child,
    required this.listener,
  }) : super(key: key);

  /// The child widget.
  final Widget child;

  /// A callback that listens to the [WizardEvent] events from the
  /// [WizardController].
  /// The events are:
  /// - [WizardEnableGoBackEvent]: Triggered when `enableGoBack` is called.
  /// - [WizardEnableGoNextEvent]: Triggered when `enableGoNext` is called.
  /// - [WizardDisableGoBackEvent]: Triggered when `disableGoBack` is called.
  /// - [WizardDisableGoNextEvent]: Triggered when `disableGoNext` is called.
  /// - [WizardGoNextEvent]: Triggered when `goNext` is called.
  /// - [WizardGoBackEvent]: Triggered when `goBack` is called.
  /// - [WizardGoToEvent]: Triggered when `goTo` is called.
  /// - [WizardForcedGoBackToEvent]: Triggered when `disableGoNext` is called
  /// with an index lower as the current index.
  final WizardEventCallback listener;

  @override
  State<WizardEventListener> createState() => _WizardEventListener();
}

class _WizardEventListener extends State<WizardEventListener> {
  WizardController? wizardController;
  StreamSubscription? streamSub;

  @override
  Widget build(
    BuildContext context,
  ) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (wizardController != context.wizardController) {
      wizardController = context.wizardController;
      streamSub?.cancel();
      streamSub = context.wizardController.eventStream.listen((event) {
        widget.listener(context, event);
      });
    }
  }

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }
}
