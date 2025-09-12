import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool expanded;

  const PrimaryButton({super.key, required this.label, required this.onPressed, this.expanded = false});

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(onPressed: onPressed, child: Text(label));
    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}
