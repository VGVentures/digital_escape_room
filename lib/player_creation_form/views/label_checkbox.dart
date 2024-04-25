import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class LabelCheckbox extends StatefulWidget {
  const LabelCheckbox({
    required this.label,
    required this.onChange,
    this.value = false,
    this.shouldExpandText = false,
    super.key,
  });

  final String label;
  final bool shouldExpandText;
  final bool value;
  final ValueChanged<bool> onChange;

  @override
  State<LabelCheckbox> createState() => _LabelCheckboxState();
}

class _LabelCheckboxState extends State<LabelCheckbox> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NesCheckBox(
          value: isSelected,
          onChange: (value) {
            widget.onChange(value);
            setState(() {
              isSelected = value;
            });
          },
        ),
        const SizedBox(width: 8),
        if (widget.shouldExpandText)
          Expanded(child: Text(widget.label))
        else
          Text(widget.label),
      ],
    );
  }
}
