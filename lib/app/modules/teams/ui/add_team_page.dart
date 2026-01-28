import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qual_time/app/core/components/team_member_card.dart';
import 'package:qual_time/app/core/components/primary_button.dart';
import 'package:qual_time/app/modules/teams/viewmodel/add_team_view_model.dart';

class AddTeamPage extends StatelessWidget {
  const AddTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTeamViewModel());
    final isEditing = controller.editingTeam != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isEditing ? 'Editar Time' : 'Adicionar Novo Time',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Section
            Text(
              'Informações Básicas',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Dê um nome criativo para sua equipe',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF667085), // Grey text
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nome do time',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.teamNameController,
              decoration: InputDecoration(
                hintText: 'Ex: Pride Vôlei',
                hintStyle: GoogleFonts.inter(color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Color(0xFF1976D2)),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Players Section
            Text(
              'Jogadores',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Adicione os atletas que compõem o time',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF667085),
              ),
            ),
            const SizedBox(height: 16),

            // Player Input Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: controller.playerInputController,
                    decoration: InputDecoration(
                      hintText: 'Nome do Jogador',
                      hintStyle: GoogleFonts.inter(color: Colors.grey.shade400),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFF1976D2)),
                      ),
                    ),
                    onSubmitted: (_) => controller.addPlayer(),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: controller.addPlayer,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1976D2), // Blue
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x331976D2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Players List
            Obx(() {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.players.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final player = controller.players[index];
                  return TeamMemberCard(
                    name: player,
                    onRemove: () => controller.removePlayer(index),
                  );
                },
              );
            }),

            const SizedBox(height: 40),

            // Save Button
            PrimaryButton(
              label: isEditing ? 'Atualizar' : 'Salvar',
              onTap: controller.saveTeam,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
