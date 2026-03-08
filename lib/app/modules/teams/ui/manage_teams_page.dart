import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/primary_button.dart';
import 'package:qual_time/app/core/components/team_management_card.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/teams/viewmodel/manage_teams_view_model.dart';
import 'package:qual_time/app/routes/app_routes.dart';
import 'package:qual_time/app/shared/ui/bottom_sheets/team_players_bottom_sheet.dart';

class ManageTeamsPage extends GetView<ManageTeamsViewModel> {
  const ManageTeamsPage({super.key});

  void _showTeamPlayers(Team team) {
    Get.bottomSheet(
      TeamPlayersBottomSheet(team: team),
      isScrollControlled: true,
    );
  }

  void _showImportDialog(BuildContext context) {
    final textController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text(
          'Importar do WhatsApp',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: textController,
          maxLines: 10,
          decoration: const InputDecoration(
            hintText: 'Cole o texto do WhatsApp aqui...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                controller.importFromWhatsApp(textController.text);
              }
              Get.back();
            },
            child: const Text('Importar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciar times',
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
            icon: const Icon(Icons.paste_rounded, color: Colors.black),
            onPressed: () => _showImportDialog(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
            child: Column(
              children: [
                Text(
                  "Toque e segure para reordenar a fila de times para o torneio.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => ReorderableListView.builder(
                      itemCount: controller.teams.length,
                      onReorder: controller.reorderTeams,
                      itemBuilder: (context, index) {
                        final team = controller.teams[index];
                        return Container(
                          key: ValueKey(team.id),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: TeamManagementCard(
                            teamName: team.name,
                            playerCount: team.players.length,
                            onTap: () => _showTeamPlayers(team),
                            onDelete: () => controller.removeTeam(team),
                            onEdit:
                                () => Get.toNamed(
                                  Routes.addTeam,
                                  arguments: team,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: PrimaryButton(
              icon: Icons.group_add_rounded,
              label: "Adicionar time",
              onTap: () {
                Get.toNamed(Routes.addTeam);
              },
            ),
          ),
        ],
      ),
    );
  }
}
