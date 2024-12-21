import 'package:flutter/material.dart';

class BouncingButtonWidget extends StatefulWidget {
  const BouncingButtonWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<BouncingButtonWidget> createState() => _BouncingButtonWidgetState();
}

class _BouncingButtonWidgetState extends State<BouncingButtonWidget>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  bool isdDisposed = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    isdDisposed = true;
    super.dispose();
  }

  void reverseAnimateBouncingButton() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerCancel: (PointerCancelEvent event) {
        _controller.reverse();
      },
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        isdDisposed ? null : _controller.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
