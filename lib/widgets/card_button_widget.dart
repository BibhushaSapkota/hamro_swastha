import 'package:flutter/material.dart';

class CardIconButton extends StatelessWidget {
  final IconData icon;

  const CardIconButton(this.icon) : super();

  @override
  Widget build(BuildContext context) {
    const Color primary = Color.fromRGBO(118, 181, 197, 1.0);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
            color: primary.withAlpha(40),
            width: 2
        ),
      ),
      child: Icon(
        icon,
        size: 25,
        color: primary,
      ),
    );
  }
}