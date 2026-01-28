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
}
