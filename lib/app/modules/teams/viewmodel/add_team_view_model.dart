import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/teams/viewmodel/manage_teams_view_model.dart';

class AddTeamViewModel extends GetxController {
  final ManageTeamsViewModel _manageTeamsViewModel = Get.find();

  final teamNameController = TextEditingController(text: 'Time');
  final playerInputController = TextEditingController();

  // Reactive list of players
  final RxList<String> players = <String>[].obs;

  void addPlayer() {
    final name = playerInputController.text.trim();
    if (name.isNotEmpty) {
      players.add(name);
      playerInputController.clear();
    }
  }

  void removePlayer(int index) {
    if (index >= 0 && index < players.length) {
      players.removeAt(index);
    }
  }

  void saveTeam() {
    final name = teamNameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Erro',
        'Por favor, insira o nome do time',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (players.isEmpty) {
      Get.snackbar(
        'Erro',
        'Adicione pelo menos um jogador',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newTeam = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      players: List.from(players),
    );

    _manageTeamsViewModel.addNewTeam(newTeam);
    Get.back();
  }

  @override
  void onClose() {
    teamNameController.dispose();
    playerInputController.dispose();
    super.onClose();
  }
}
