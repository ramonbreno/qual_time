import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/ranking_team_card.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/ranking/viewmodel/ranking_view_model.dart';
import 'package:qual_time/app/shared/ui/bottom_sheets/team_players_bottom_sheet.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  void _showTeamPlayers(Team team) {
    Get.bottomSheet(
      TeamPlayersBottomSheet(team: team),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // If the controller isn't registered in bindings, put it here.
    // Given the flow, it's safer to put it here if not already.
    final RankingViewModel controller = Get.put(RankingViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final teams = controller.rankedTeams;

        if (teams.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhum time no ranking',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: teams.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final team = teams[index];
            return RankingTeamCard(
              position: index + 1,
              teamName: team.name,
              wins: team.wins,
              losses: team.losses,
              onTap: () => _showTeamPlayers(team),
            );
          },
        );
      }),
    );
  }
}
