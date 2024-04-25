import 'package:digital_escape_room/l10n/l10n.dart';
import 'package:digital_escape_room/player_creation_form/player_creation_form.dart';
import 'package:flutter/material.dart';

class AreasOfInterest extends StatefulWidget {
  const AreasOfInterest({required this.onChange, super.key});

  final ValueChanged<List<String>> onChange;

  @override
  State<AreasOfInterest> createState() => _AreasOfInterestState();
}

class _AreasOfInterestState extends State<AreasOfInterest> {
  List<String> areasOfInterest = <String>[];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.pickThreeAreas),
        const SizedBox(height: 20),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            LabelCheckbox(
              label: l10n.infrastructure,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.infrastructure);
              },
            ),
            LabelCheckbox(
              label: l10n.ai,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.ai);
              },
            ),
            LabelCheckbox(
              label: l10n.mobileApps,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.mobileApps);
              },
            ),
            LabelCheckbox(
              label: l10n.devOps,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.devOps);
              },
            ),
            LabelCheckbox(
              label: l10n.uiUx,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.uiUx);
              },
            ),
            LabelCheckbox(
              label: l10n.productDevelopment,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.productDevelopment);
              },
            ),
            LabelCheckbox(
              label: l10n.web,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.web);
              },
            ),
            LabelCheckbox(
              label: l10n.ar,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.ar);
              },
            ),
            LabelCheckbox(
              label: l10n.databases,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.databases);
              },
            ),
            LabelCheckbox(
              label: l10n.apis,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.apis);
              },
            ),
            LabelCheckbox(
              label: l10n.security,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.security);
              },
            ),
            LabelCheckbox(
              label: l10n.testing,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.testing);
              },
            ),
            LabelCheckbox(
              label: l10n.productivity,
              onChange: (isChecked) {
                _updateCheckedItem(isChecked, l10n.productivity);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _updateCheckedItem(bool isChecked, String label) {
    setState(() {
      if (isChecked) {
        areasOfInterest.add(label);
      } else {
        areasOfInterest.remove(label);
      }
      widget.onChange(areasOfInterest);
    });
  }
}
