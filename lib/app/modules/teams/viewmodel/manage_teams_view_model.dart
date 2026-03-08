import 'package:get/get.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';

class ManageTeamsViewModel extends GetxController {
  final RxList<Team> teams = <Team>[].obs;

  void reorderTeams(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Team item = teams.removeAt(oldIndex);
    teams.insert(newIndex, item);
  }

  void addNewTeam(Team team) {
    teams.add(team);
  }

  void removeTeam(Team team) {
    teams.remove(team);
  }

  void updateTeam(Team updatedTeam) {
    final index = teams.indexWhere((t) => t.id == updatedTeam.id);
    if (index != -1) {
      teams[index] = updatedTeam;
    }
  }

  void importFromWhatsApp(String text) {
    final lines = text.split('\n');
    String? currentTeamName;
    List<String> currentPlayers = [];

    void saveCurrentTeam() {
      if (currentTeamName != null) {
        final existingIndex = teams.indexWhere(
          (t) => t.name.toLowerCase() == currentTeamName!.toLowerCase(),
        );

        if (existingIndex != -1) {
          final existingTeam = teams[existingIndex];
          teams[existingIndex] = existingTeam.copyWith(players: currentPlayers);
        } else {
          final newTeam = Team(
            id:
                DateTime.now().microsecondsSinceEpoch.toString() +
                currentTeamName.hashCode.toString(),
            name: currentTeamName,
            players: currentPlayers,
          );
          teams.add(newTeam);
        }
      }
    }

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      if (line.toLowerCase().startsWith('time ')) {
        saveCurrentTeam();
        currentTeamName = line;
        currentPlayers = [];
      } else {
        if (currentTeamName != null) {
          currentPlayers.add(line);
        }
      }
    }

    saveCurrentTeam();
  }
}
