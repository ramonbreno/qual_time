import 'package:get/get.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/match/viewmodel/match_view_model.dart';

class RankingViewModel extends GetxController {
  final MatchViewModel _matchViewModel = Get.find();

  List<Team> get rankedTeams {
    // Accessing _matchViewModel.state (via .teams internal logic or directly)
    // inside an Obx in the view will trigger rebuilds.
    // However, .teams in MatchViewModel is a getter.
    // We rely on the fact that .teams accesses state properties which likely triggers listeners
    // IF the state variable itself is accessed.
    // Let's ensure we are reactive.

    // _matchViewModel.teams access 'state' which is a getter for _state.value.
    // _state is Rxn. So yes, checking .value registers it.

    final allTeams = List<Team>.from(_matchViewModel.teams);

    // Sort by wins descending
    allTeams.sort((a, b) => b.wins.compareTo(a.wins));

    return allTeams;
  }
}
