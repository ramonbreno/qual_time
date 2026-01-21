import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankingTeamCard extends StatelessWidget {
  final int position;
  final String teamName;
  final int wins;
  final int losses;
  final VoidCallback? onTap;

  const RankingTeamCard({
    super.key,
    required this.position,
    required this.teamName,
    required this.wins,
    required this.losses,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                // Blue Bar Indicator
                Container(
                  width: 4,
                  height: double.infinity,
                  color: const Color(0xFF1976D2),
                ),
                const SizedBox(width: 12),
                // Position Badge
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD), // Light Blue
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$positionº',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF1976D2), // Dark Blue
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Team Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teamName,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Vitórias: $wins',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF536A92),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 1,
                            height: 12,
                            color: Colors.grey.shade300,
                          ),
                          Text(
                            'Derrotas: $losses',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF536A92),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
