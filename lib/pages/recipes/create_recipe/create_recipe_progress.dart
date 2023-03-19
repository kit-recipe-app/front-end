import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class Progress extends StatelessWidget {
  final int total;
  final int current;
  const Progress({Key? key, required this.total, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,30,16,0),
      child: StepProgressIndicator(
        totalSteps: total,
        currentStep: current,
        size: 10,
        roundedEdges: const Radius.circular(15),
        selectedColor: const Color(0xff66aa44),
        unselectedColor: Colors.grey,
      ),
    );
  }
}
