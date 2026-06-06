import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamCircle extends StatelessWidget {
  final String name;
  final Color color;
  final double size;
  final VoidCallback? onTap;

  const TeamCircle({
    super.key,
    required this.name,
    required this.color,
    this.size = 120.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          name.toUpperCase(),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: size * 0.18,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
