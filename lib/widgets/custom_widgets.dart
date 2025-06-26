import 'package:flutter/material.dart';

Widget buildStyledCard({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
}) {
  return Container(
    padding: padding,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: child,
  );
}
