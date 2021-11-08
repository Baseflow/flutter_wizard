import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../flutter_wizard.dart';

abstract class WizardController {
  /// Coordinates the wizard steps and its input control states
  ///
  /// stepStates: The step states. This property determines the order of the
  /// steps. Also this step can contain ever state management solution that you
  /// wish. A list of providers, bloc, etc can be passed in here.
  ///
  /// stepBuilder: The builder method to build the step view. The builder method
  /// provides the [BuildContext] and [WizardStepState]. The state can then be
  /// used to determine how to build the view.
  ///
  /// Example:
  /// ```dart
  /// stepBuilder: (context, state) {
  ///   if (state is StepOneProvider) {
  ///     return StepOne(
  ///       provider: state,
  ///     );
  ///   }
  ///   if (state is StepTwoProvider) {
  ///     return StepTwo(
  ///       provider: state,
  ///     );
  ///   }
  ///   return Container();
  /// },
  /// ```
  ///
  /// initialIndex: Indicates the initial index of the wizard.
  ///
  /// initialIsPreviousEnabled: Indicates if the previous button will be enabled
  /// on the initial load.
  ///
  /// initialIsNextEnabled: Indicates if the previous button will be enabled on
  /// the initial load.
  ///
  /// initialIsFinishEnabled: Indicates if the finish button will be enabled on
  /// the initial load.
  ///
  /// onStepChanged: Callback that gets triggered when the step changes.
  factory WizardController({
    required List<WizardStepController> stepControllers,
    int initialIndex = 0,
    StepCallback? onStepChanged,
  }) {
    return WizardControllerImpl(
      stepControllers: stepControllers,
      initialIndex: initialIndex,
      onStepChanged: onStepChanged,
    );
  }

  /// Controller to control the page view.
  PageController get pageController;

  /// The step controllers.
  List<WizardStepController> get stepControllers;

  /// The step count.
  int get stepCount;

  /// Indicates whether the step index matches the first step.
  bool isFirstStep(int index);

  /// Indicates whether the step index matches the last step.
  bool isLastStep(int index);

  /// Streams the wizard step index.
  Stream<int> get indexStream;

  /// The current wizard step index.
  int get index;

  /// Gets the index for the provided step.
  int getStepIndex(
    WizardStep step,
  );

  /// Streams whether the back button is enabled for current index.
  Stream<bool> getIsGoBackEnabledStream();

  /// Indicates whether the back button currently is enabled for current index.
  bool getIsGoBackEnabled();

  /// Enable the previous button for specified index.
  void enableGoBack(
    int index,
  );

  /// Disable the previous button for specified index.
  void disableGoBack(
    int index,
  );

  /// Stream whether the next button is enabled for current index.
  Stream<bool> getIsGoNextEnabledStream();

  /// Indicates whether the next button currently is enabled for current index.
  bool getIsGoNextEnabled();

  /// Stream whether its allowed to animate to specified index.
  Stream<bool> getIsAnimateToEnabledStream(
    int index,
  );

  /// Indicates whether its allowed to animate to specified index.
  bool getIsAnimateToEnabled(
    int index,
  );

  /// Enable the next button for specified index.
  void enableGoNext(
    int index,
  );

  /// Disable the next button for specified index.
  void disableGoNext(
    int index,
  );

  /// Show the next step. If the current step equals the last step nothing will
  /// happen.
  Future<void> next({
    Duration delay,
    Duration duration,
    Curve curve,
  });

  /// Animate to the step index. If the current step index equals the provided
  /// step index nothing will happen.
  Future<void> animateTo({
    required int index,
    Duration delay,
    Duration duration,
    Curve curve,
  });

  /// Show the previous step. If current step equals the first step nothing
  /// will happen.
  Future<void> previous({
    Duration duration,
    Curve curve,
  });

  /// Dispose the controller
  void dispose();

  /// The closest instance of this class that encloses the given context.
  ///
  /// {@tool snippet}
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// WizardController controller = DefaultWizardController.of(context);
  /// ```
  /// {@end-tool}
  static WizardController of(
    BuildContext context,
  ) {
    final _WizardControllerScope? scope =
        context.dependOnInheritedWidgetOfExactType<_WizardControllerScope>();
    final controller = scope?.controller;
    if (controller == null) {
      // TODO: improve
      throw Exception(
        "No wizard controller can be found within the widget tree. Please make sure your widget is wrapped with a DefaultWizardController widget.",
      );
    }
    return controller;
  }
}

class WizardControllerImpl implements WizardController {
  WizardControllerImpl({
    required List<WizardStepController> stepControllers,
    int initialIndex = 0,
    StepCallback? onStepChanged,
  })  : stepControllers = List.unmodifiable(stepControllers),
        pageController = PageController(
          initialPage: initialIndex,
        ),
        _index = BehaviorSubject<int>.seeded(
          initialIndex,
        ),
        _onStepChanged = onStepChanged {
    _setWizardControllerInSteps();
  }

  void _setWizardControllerInSteps() {
    for (final controller in stepControllers) {
      controller.step.wizardController = this;
    }
  }

  final BehaviorSubject<int> _index;

  final StepCallback? _onStepChanged;

  @override
  final List<WizardStepController> stepControllers;

  @override
  final PageController pageController;

  @override
  Stream<int> get indexStream => _index.stream.asBroadcastStream();

  @override
  int get index => _index.value;

  @override
  int get stepCount => stepControllers.length;

  @override
  bool isFirstStep(int index) => index == 0;

  @override
  bool isLastStep(int index) => index == stepCount - 1;

  @override
  Future<void> next({
    Duration? delay,
    Duration duration = const Duration(milliseconds: 150),
    Curve curve = Curves.easeIn,
  }) async {
    if (isLastStep(index) || !getIsGoNextEnabled()) {
      return;
    }
    final delayUntil = DateTime.now().add(duration);
    final oldIndex = index;
    final newIndex = oldIndex + 1;
    if (_onStepChanged != null) {
      await _onStepChanged!(
        oldIndex,
        index,
      );
    }
    final now = DateTime.now();
    if (delay != null && delayUntil.isAfter(now)) {
      final realDelay = Duration(
        milliseconds:
            delayUntil.millisecondsSinceEpoch - now.millisecondsSinceEpoch,
      );
      await Future.delayed(realDelay);
    }
    _index.add(newIndex);
    await Future.wait([
      stepControllers[newIndex].step.onShowing(),
      stepControllers[oldIndex].step.onHiding(),
      pageController.nextPage(
        duration: duration,
        curve: curve,
      ),
    ]);
    await Future.wait([
      stepControllers[newIndex].step.onShowingCompleted(),
      stepControllers[oldIndex].step.onHidingCompleted(),
    ]);
  }

  @override
  Future<void> previous({
    Duration duration = const Duration(milliseconds: 150),
    Curve curve = Curves.easeIn,
  }) async {
    if (isFirstStep(index) || !getIsGoBackEnabled()) {
      return;
    }
    final oldIndex = index;
    final newIndex = oldIndex - 1;
    if (_onStepChanged != null) {
      await _onStepChanged!(
        oldIndex,
        index,
      );
    }
    _index.add(newIndex);
    await Future.wait([
      stepControllers[newIndex].step.onShowing(),
      stepControllers[oldIndex].step.onHiding(),
      pageController.previousPage(
        duration: duration,
        curve: curve,
      ),
    ]);
    await Future.wait([
      stepControllers[newIndex].step.onShowingCompleted(),
      stepControllers[oldIndex].step.onHidingCompleted(),
    ]);
  }

  @override
  Future<void> animateTo({
    required int index,
    Duration? delay,
    Duration duration = const Duration(milliseconds: 150),
    Curve curve = Curves.easeIn,
  }) async {
    if (this.index == index || !getIsAnimateToEnabled(index)) {
      return;
    }
    final delayUntil = DateTime.now().add(duration);
    final oldIndex = this.index;
    final newIndex = index;
    if (_onStepChanged != null) {
      await _onStepChanged!(
        oldIndex,
        index,
      );
    }
    final now = DateTime.now();
    if (delay != null && delayUntil.isAfter(now)) {
      final realDelay = Duration(
        milliseconds:
            delayUntil.millisecondsSinceEpoch - now.millisecondsSinceEpoch,
      );
      await Future.delayed(realDelay);
    }
    _index.add(newIndex);
    await Future.wait([
      stepControllers[newIndex].step.onShowing(),
      stepControllers[oldIndex].step.onHiding(),
      pageController.animateToPage(
        newIndex,
        duration: duration,
        curve: curve,
      ),
    ]);
    await Future.wait([
      stepControllers[newIndex].step.onShowingCompleted(),
      stepControllers[oldIndex].step.onHidingCompleted(),
    ]);
  }

  @override
  void dispose() {
    pageController.dispose();
    _index.close();
  }

  int _getIndex(
    int? index,
  ) {
    if (index == null) {
      return this.index;
    }
    if (index <= 0) {
      return 0;
    }
    if (index >= stepControllers.length - 1) {
      return stepControllers.length - 1;
    }
    return index;
  }

  WizardStepController _getStepController(
    int? index,
  ) {
    return stepControllers[_getIndex(index)];
  }

  @override
  void disableGoBack(
    int index,
  ) {
    _getStepController(index).disableGoBack();
  }

  @override
  void disableGoNext(
    int index,
  ) {
    _getStepController(index).disableGoNext();
  }

  @override
  void enableGoBack(
    int? index,
  ) {
    _getStepController(index).enableGoBack();
  }

  @override
  void enableGoNext(
    int? index,
  ) {
    _getStepController(index).enableGoNext();
  }

  @override
  bool getIsGoBackEnabled() {
    return stepControllers[index].isGoBackEnabled;
  }

  @override
  Stream<bool> getIsGoBackEnabledStream() {
    return indexStream.switchMap((index) {
      return stepControllers[index].isGoBackEnabledStream;
    });
  }

  @override
  bool getIsGoNextEnabled() {
    return stepControllers[index].isGoNextEnabled;
  }

  @override
  Stream<bool> getIsGoNextEnabledStream([
    int? index,
  ]) {
    return indexStream.switchMap((index) {
      return stepControllers[index].isGoNextEnabledStream;
    });
  }

  @override
  bool getIsAnimateToEnabled(
    int index,
  ) {
    final indexes = _generateIndexList(index - 1);
    for (final index in indexes) {
      if (!stepControllers[index].isGoNextEnabled) {
        return false;
      }
    }
    return true;
  }

  @override
  Stream<bool> getIsAnimateToEnabledStream(
    int index,
  ) {
    final indexes = _generateIndexList(index - 1);
    return Rx.combineLatestList(
      indexes.map((index) => stepControllers[index].isGoNextEnabledStream),
    ).map((isGoNextEnabledList) {
      return isGoNextEnabledList.every((isGoNextEnabled) => isGoNextEnabled);
    });
  }

  List<int> _generateIndexList(
    int index,
  ) {
    return List.generate(index + 1, (index) => index);
  }

  @override
  int getStepIndex(
    WizardStep step,
  ) {
    return stepControllers.indexWhere(
      (controller) => controller.step == step,
    );
  }
}

class _WizardControllerScope extends InheritedWidget {
  const _WizardControllerScope({
    Key? key,
    required this.controller,
    required this.enabled,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  final WizardController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_WizardControllerScope old) {
    return enabled != enabled || controller != old.controller;
  }
}

class DefaultWizardController extends StatefulWidget {
  const DefaultWizardController({
    required this.stepControllers,
    this.initialIndex = 0,
    this.onStepChanged,
    this.onControllerCreated,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The step controllers. This property determines the order of the steps.
  final List<WizardStepController> stepControllers;

  /// Indicates the initial index of the wizard.
  final int initialIndex;

  /// Callback that gets triggered when the step changes.
  final StepCallback? onStepChanged;

  /// The child widget
  final Widget child;

  /// Callback that gets triggered when the [WizardController] is created.
  final FutureOr<void> Function(WizardController controller)?
      onControllerCreated;

  @override
  _DefaultWizardControllerState createState() =>
      _DefaultWizardControllerState();
}

class _DefaultWizardControllerState extends State<DefaultWizardController> {
  /// The controller to control the wizard
  late WizardController controller;

  @override
  void initState() {
    _createController();
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant DefaultWizardController oldWidget,
  ) {
    // TODO: improve to copy with
    controller.dispose();
    _createController();
    super.didUpdateWidget(oldWidget);
  }

  void _createController() {
    controller = WizardController(
      stepControllers: widget.stepControllers,
      initialIndex: widget.initialIndex,
      onStepChanged: widget.onStepChanged,
    );
    if (widget.onControllerCreated != null) {
      widget.onControllerCreated!(controller);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return _WizardControllerScope(
      controller: controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
