import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';

class PrimaryCTAButton extends StatefulWidget {
  const PrimaryCTAButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.leadingIcon,
    this.width = double.infinity,
    this.height = 58,
    this.enabled = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leadingIcon;
  final double width;
  final double height;
  final bool enabled;

  @override
  State<PrimaryCTAButton> createState() => _PrimaryCTAButtonState();
}

class _PrimaryCTAButtonState extends State<PrimaryCTAButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = !widget.enabled;

    return GestureDetector(
      onTapDown: disabled ? null : (_) => setState(() => pressed = true),
      onTapUp: disabled
          ? null
          : (_) {
              setState(() => pressed = false);
              widget.onPressed?.call();
            },
      onTapCancel: disabled ? null : () => setState(() => pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.translationValues(0, pressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.outlineVariant
              : AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: disabled
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(.18),
                    blurRadius: 24,
                    offset: Offset(0, pressed ? 2 : 8),
                  ),
                ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leadingIcon != null) ...[
                Icon(
                  widget.leadingIcon,
                  color: Colors.indigo.shade900,
                  size: 18,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 10),
                Icon(widget.icon, color: Colors.indigo.shade900, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
