import 'dart:async';

import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/rxdart.dart';

import '../../example.dart';

class StepTwoProvider with WizardStep, DisposableMixin {
  StepTwoProvider()
      : _options = BehaviorSubject<List<String>>.seeded(['A', 'B']),
        _selection = BehaviorSubject<String?>.seeded(null) {
    _selection.takeUntil(dispose$).listen((selection) {
      final index = wizardController.getStepIndex(this);
      if (selection != null) {
        wizardController.enableGoNext(index);
      } else {
        wizardController.disableGoNext(index);
      }
    });

    Stream.periodic(
      const Duration(seconds: 3),
    ).listen((_) {
      if (selection == 'B') {
        select(selection!);
      }
    });
  }

  final BehaviorSubject<List<String>> _options;
  final BehaviorSubject<String?> _selection;

  List<String> get options {
    return _options.value;
  }

  Stream<List<String>> get optionsStream {
    return _options.stream.asBroadcastStream();
  }

  String? get selection {
    return _selection.value;
  }

  Stream<String?> get selectionStream {
    return _selection.stream.asBroadcastStream().distinct();
  }

  void select(
    String option,
  ) {
    _selection.add(_selection.value != option ? option : null);
  }

  @override
  void dispose() {
    _selection.close();
    _options.close();
    super.dispose();
  }
}
