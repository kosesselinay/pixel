import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Curve curve;
  final Offset offset;

  DelayedAnimation(
      {required this.child,
      required this.delay,
      required this.curve,
      required this.offset});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    final curve = CurvedAnimation(curve: widget.curve, parent: _controller);
    if (widget.offset == null) {
      _animOffset = Tween<Offset>(begin: const Offset(0.0, 1), end: Offset.zero)
          .animate(curve);
    } else
      _animOffset =
          Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}
