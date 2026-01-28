import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum PrimaryButtonType { primary, confirm, disabled }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final IconData? icon;
  final PrimaryButtonType type;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.icon,
    this.type = PrimaryButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ??
        switch (type) {
          PrimaryButtonType.primary => const Color(0xFF1976D2),
          PrimaryButtonType.confirm => const Color(0xFF0F9D58),
          PrimaryButtonType.disabled => const Color(0xFFF1F3F4),
        };

    final effectiveTextColor =
        type == PrimaryButtonType.disabled
            ? const Color(0xFF5F6368)
            : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            if (type != PrimaryButtonType.disabled)
              BoxShadow(
                color: effectiveColor.withValues(alpha: 0.4),
                offset: const Offset(0, 8),
                blurRadius: 16,
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: effectiveTextColor, size: 24),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: effectiveTextColor,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
