import 'package:flutter/material.dart';
import 'package:monda_edoctor/_0__infra/style.dart';

typedef void OnCounterValueChanged(int newValue);

class StepCounter extends StatefulWidget {
  final StepCounterController controller;

  final double width;

  final double height;

  final double buttonHeight;

  final double buttonWidth;

  final TextStyle buttonTextStyle;

  final TextStyle valueTextStyle;

  final double gap;

  final OnCounterValueChanged onCounterValueChanged;

  StepCounter(
      {required this.controller,
      required this.width,
      required this.height,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.gap,
      required this.buttonTextStyle,
      required this.valueTextStyle,
      required this.onCounterValueChanged});

  createState() => StepCounterState();
}

class StepCounterState extends State<StepCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Row(
        children: [
          _decreaseButton(context),
          SizedBox(width: widget.gap,),
          Expanded(
            child: _valueLabel(context),
          ),
          SizedBox(width: widget.gap,),
          _increaseButton(context),
        ],
      ),
    );
  }

  Widget _valueLabel(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Style.colorPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Style.colorPrimary.withOpacity(0.3),
        ),
      ),
      child: Center(
        child: Text(
          '${widget.controller.value}',
          style: widget.valueTextStyle,
        ),
      ),
    );
  }

  Widget _decreaseButton(BuildContext context) {
    return Container(
      width: widget.buttonWidth,
      height: widget.buttonHeight,
      decoration: BoxDecoration(
        color: Style.colorPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Style.colorPrimary.withOpacity(0.3),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (widget.controller.minValue == null) {
              widget.controller.value--;
            } else {
              if (widget.controller.value > widget.controller.minValue!) {
                widget.controller.value--;
              }
            }

            widget.onCounterValueChanged(widget.controller.value);
          });
        },
        child: Center(
          child: Text(
            '-',
            style: widget.buttonTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _increaseButton(BuildContext context) {
    return Container(
      width: widget.buttonWidth,
      height: widget.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Style.colorPrimary.withOpacity(0.2),
        border: Border.all(
          color: Style.colorPrimary.withOpacity(0.3),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if(widget.controller.maxValue == null) {
              widget.controller.value++;
            } else {
              if(widget.controller.maxValue! > widget.controller.value) {
                widget.controller.value++;
              }
            }

            widget.onCounterValueChanged(widget.controller.value);
          });
        },
        child: Center(
          child: Text(
            '+',
            style: widget.buttonTextStyle,
          ),
        ),
      ),
    );
  }
}

class StepCounterController {
  int value = 0;

  int? maxValue;

  int? minValue;

  StepCounterController({required this.value, this.maxValue, this.minValue});
}
