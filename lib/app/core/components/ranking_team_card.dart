import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum RankingPosition {
  first,
  second,
  third,
  common;

  static RankingPosition fromPosition(int position) {
    if (position == 1) return RankingPosition.first;
    if (position == 2) return RankingPosition.second;
    if (position == 3) return RankingPosition.third;
    return RankingPosition.common;
  }

  Color get indicatorColor {
    switch (this) {
      case RankingPosition.first:
        return const Color(0xFFFFD600); // Yellow/Gold
      case RankingPosition.second:
        return const Color(0xFFCFD8DC); // Grey/Silver
      case RankingPosition.third:
        return const Color(0xFFCD7F32); // Bronze/Orange
      case RankingPosition.common:
        return const Color(0xFF1976D2); // Default Blue
    }
  }

  Color get badgeBackgroundColor {
    switch (this) {
      case RankingPosition.first:
        return const Color(0xFFFFF9C4);
      case RankingPosition.second:
        return const Color(0xFFF5F5F5);
      case RankingPosition.third:
        return const Color(0xFFFBE9E7);
      case RankingPosition.common:
        return const Color(0xFFE3F2FD);
    }
  }

  Color get badgeTextColor {
    switch (this) {
      case RankingPosition.first:
        return const Color(0xFF212121);
      case RankingPosition.second:
        return const Color(0xFF546E7A);
      case RankingPosition.third:
        return const Color(0xFFCD7F32);
      case RankingPosition.common:
        return const Color(0xFF1976D2);
    }
  }

  double get cardScale {
    return this == RankingPosition.first ? 1.05 : 1.0;
  }
}

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
    final rankEnum = RankingPosition.fromPosition(position);
    final isFirst = rankEnum == RankingPosition.first;

    final card = Container(
      height: 85,
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
                // Color Bar Indicator
                Container(
                  width: 6,
                  height: double.infinity,
                  color: rankEnum.indicatorColor,
                ),
                const SizedBox(width: 12),

                // Position Badge
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: rankEnum.badgeBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$positionº',
                        style: GoogleFonts.inter(
                          color: rankEnum.badgeTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    if (isFirst)
                      const Padding(
                        padding: EdgeInsets.only(top: 2, right: 2),
                        child: Icon(
                          Icons.emoji_events,
                          color: Color(0xFFFFD600),
                          size: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // Team Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              teamName,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E293B), // Dark text
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isFirst) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD600),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'TIME DA NOITE',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$losses ${losses == 1 ? 'Derrota' : 'Derrotas'}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFF64748B), // Subtle grey text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Wins side
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$wins',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                          height: 1.0,
                        ),
                      ),
                      Text(
                        'VITS',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF64748B),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (isFirst) {
      return Transform.scale(scale: rankEnum.cardScale, child: card);
    }

    return card;
  }
}
