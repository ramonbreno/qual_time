import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QueueTeamCard extends StatelessWidget {
  final int position;
  final String teamName;
  final VoidCallback? onTap;

  const QueueTeamCard({
    super.key,
    required this.position,
    required this.teamName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Indicator - Position
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$position',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Middle Content - Team Name
            Expanded(
              child: Text(
                teamName,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            // Right Indicator - Status Dot
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.green, // Active/Ready status
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
