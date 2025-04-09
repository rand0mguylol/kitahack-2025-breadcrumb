import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar(
      {super.key, required this.progressValue, double? height, Color? color})
      : height = height ?? 15,
        color = color ?? Colors.blue;

  final double progressValue;
  final double height;
  final Color color;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: widget.color,
      minHeight: widget.height,
      borderRadius: BorderRadius.circular(20),
      value: widget.progressValue,
      semanticsLabel: 'Linear progress indicator',
    );
  }
}
