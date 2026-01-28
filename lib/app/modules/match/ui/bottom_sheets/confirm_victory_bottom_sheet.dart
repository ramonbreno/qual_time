import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/team_member_card.dart';
import 'package:qual_time/app/core/components/primary_button.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:get/get.dart';

class ConfirmVictoryBottomSheet extends StatelessWidget {
  final Team team;
  final VoidCallback onConfirm;

  const ConfirmVictoryBottomSheet({
    super.key,
    required this.team,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Confirmar Vitória',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            team.name, // "Time Alpha" is implied to be the team name.
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(
                0xFF1976D2,
              ), // Using a blue similar to the image
            ),
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'JOGADORES',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: const Color(0xFF667085),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Assuming list is short enough or sheet is scroll controlled
              itemCount: team.players.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return TeamMemberCard(name: team.players[index]);
              },
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Cancelar',
                  onTap: () => Get.back(),
                  type: PrimaryButtonType.disabled,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: PrimaryButton(
                  label: 'Confirmar',
                  onTap: onConfirm,
                  type: PrimaryButtonType.confirm,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
