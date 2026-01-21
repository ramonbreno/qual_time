import 'package:get/get.dart';
import 'package:qual_time/app/modules/match/viewmodel/match_view_model.dart';
import 'package:qual_time/app/modules/teams/viewmodel/manage_teams_view_model.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManageTeamsViewModel(), permanent: true);
    Get.put(MatchViewModel(), permanent: true);
  }
}
