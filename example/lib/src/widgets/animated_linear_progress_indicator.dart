import 'package:flutter/material.dart';

class AnimatedLinearProgressIndicator extends StatefulWidget {
  const AnimatedLinearProgressIndicator({
    Key? key,
    this.duration = const Duration(milliseconds: 150),
    required this.value,
  })  : assert(value >= 0),
        assert(value <= 1),
        super(key: key);

  final Duration duration;
  final double value;

  @override
  _AnimatedLinearProgressIndicatorState createState() =>
      _AnimatedLinearProgressIndicatorState();
}

class _AnimatedLinearProgressIndicatorState
    extends State<AnimatedLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _value;

  @override
  void initState() {
    _updateController();
    _updateValueAnimation(
      begin: 0,
      end: widget.value,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant AnimatedLinearProgressIndicator oldWidget,
  ) {
    final durationUpdated = widget.duration != oldWidget.duration;
    if (durationUpdated) {
      _controller.dispose();
      _updateController();
    }
    final valueUpdated = widget.value != oldWidget.value;
    if (durationUpdated || valueUpdated) {
      _updateValueAnimation(
        begin: oldWidget.value,
        end: widget.value,
      );
      _controller
        ..reset()
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _updateController() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  void _updateValueAnimation({
    required double begin,
    required double end,
  }) {
    _value = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: begin > end ? Curves.easeIn : Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedBuilder(
      key: widget.key,
      animation: _controller,
      builder: (_, __) {
        return LinearProgressIndicator(
          value: _value.value,
        );
      },
    );
  }
}
