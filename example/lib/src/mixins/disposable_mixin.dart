import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin DisposableMixin {
  final _dispose$ = PublishSubject<void>();

  Stream<void> get dispose$ => _dispose$.stream.asBroadcastStream();

  @mustCallSuper
  void dispose() {
    _dispose$
      ..add(null)
      ..close();
  }
}
