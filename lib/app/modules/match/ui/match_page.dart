import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/primary_button.dart';
import 'package:qual_time/app/core/components/queue_team_card.dart';
import 'package:qual_time/app/core/components/resting_team_card.dart';
import 'package:qual_time/app/core/components/team_circle.dart';
import 'package:qual_time/app/core/components/win_streak_badge.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/match/ui/components/empty_match_state.dart';
import 'package:qual_time/app/modules/match/viewmodel/match_view_model.dart';
import 'package:qual_time/app/routes/app_routes.dart';
import 'package:qual_time/app/shared/ui/bottom_sheets/team_players_bottom_sheet.dart';
import 'package:qual_time/app/modules/match/ui/bottom_sheets/confirm_victory_bottom_sheet.dart';

class MatchPage extends GetView<MatchViewModel> {
  const MatchPage({super.key});

  void _showTeamPlayers(Team team) {
    Get.bottomSheet(
      TeamPlayersBottomSheet(team: team),
      isScrollControlled: true,
    );
  }

  void _showConfirmVictory(Team team) {
    Get.bottomSheet(
      ConfirmVictoryBottomSheet(
        team: team,
        onConfirm: () {
          controller.onTeamWon(team.id);
          Get.back();
        },
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jogo Atual',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.blueGrey),
            onPressed: () {
              if (controller.state != null) {
                Get.defaultDialog(
                  title: 'Reiniciar Jogo',
                  middleText:
                      'Tem certeza que deseja reiniciar o jogo? O progresso atual será perdido.',
                  textConfirm: 'Reiniciar',
                  textCancel: 'Cancelar',
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.resetMatch();
                    Get.back();
                  },
                );
              } else {
                Get.snackbar(
                  'Aviso',
                  'Nenhum jogo em andamento para reiniciar.',
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (controller.state == null) {
            if (controller.teamCount <= 2) {
              return EmptyMatchState(
                message: 'Cadastre os times para começar o torneio',
                buttonLabel: 'Cadastrar Times',
                isRegistration: true,
                onTap: () => Get.toNamed(Routes.addTeam),
              );
            } else {
              return EmptyMatchState(
                message: 'Times cadastrados e prontos para o jogo!',
                buttonLabel: 'Começar Jogo',
                onTap: controller.startMatch,
              );
            }
          }

          final currentMatch = controller.currentMatch;
          final restingTeam = controller.restingTeam;
          final queue = controller.state?.queue ?? [];

          if (currentMatch == null) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 150, // Reserve space for badge
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              TeamCircle(
                                name: currentMatch.left.name,
                                color: const Color(0xFF1976D2), // Blue
                                size: 130,
                                onTap:
                                    () => _showTeamPlayers(currentMatch.left),
                              ),
                              if ((currentMatch.left.consecutiveWins ?? 0) > 0)
                                Positioned(
                                  top: 0,
                                  child: WinStreakBadge(
                                    wins: currentMatch.left.consecutiveWins!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          label: 'VENCEU',
                          onTap: () => _showConfirmVictory(currentMatch.left),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: IconButton(
                      onPressed: controller.swapTeams,
                      icon: const Icon(
                        Icons.swap_horiz_rounded,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 150, // Reserve space for badge
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              TeamCircle(
                                name: currentMatch.right.name,
                                color: const Color(0xFFFF6D00), // Orange
                                size: 130,
                                onTap:
                                    () => _showTeamPlayers(currentMatch.right),
                              ),
                              if ((currentMatch.right.consecutiveWins ?? 0) > 0)
                                Positioned(
                                  top: 0,
                                  child: WinStreakBadge(
                                    wins: currentMatch.right.consecutiveWins!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          label: 'VENCEU',
                          onTap: () => _showConfirmVictory(currentMatch.right),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Divider(color: Colors.grey.shade200, thickness: 1),
              const SizedBox(height: 24),

              // Resting Section
              Text(
                'Time do Retorno',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              if (restingTeam != null)
                RestingTeamCard(
                  teamName: restingTeam.name,
                  status: 'Aguardando após 2 vitórias',
                  onTap: () => _showTeamPlayers(restingTeam),
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Text(
                      'Nenhum time descansando',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // Queue Section
              Text(
                'Próximos na Fila',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              if (queue.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Fila vazia',
                      style: GoogleFonts.inter(color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: queue.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final team = queue[index];
                    return QueueTeamCard(
                      position: index + 1,
                      teamName: team.name,
                      onTap: () {
                        _showTeamPlayers(team);
                      },
                    );
                  },
                ),
              const SizedBox(height: 40),
            ],
          );
        }),
      ),
    );
  }
}
