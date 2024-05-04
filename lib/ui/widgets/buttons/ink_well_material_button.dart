import 'package:flutter/material.dart';

class InkWellMaterialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? color;
  final double? borderRadius;

  const InkWellMaterialButton({
    required this.onTap,
    required this.child,
    this.color,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20)),
      color: color ?? Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20)),
        onTap: onTap,
        child: child,
      ),
    );
}
