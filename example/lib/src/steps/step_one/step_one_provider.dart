import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wizard/flutter_wizard.dart';
import 'package:rxdart/rxdart.dart';

class StepOneProvider with WizardStep {
  StepOneProvider();

  final _description = BehaviorSubject<String>.seeded('');

  final descriptionFocusNode = FocusNode();

  final descriptionTextController = TextEditingController();

  String get description {
    return _description.value;
  }

  @override
  Future<void> onShowing() async {
    if (_description.value.isEmpty) {
      descriptionFocusNode.requestFocus();
    }
  }

  @override
  Future<void> onHiding() async {
    if (descriptionFocusNode.hasFocus) {
      descriptionFocusNode.unfocus();
    }
  }

  void updateDescription(String description) {
    _description.add(description);
  }

  void dispose() {
    descriptionTextController.dispose();
  }
}
