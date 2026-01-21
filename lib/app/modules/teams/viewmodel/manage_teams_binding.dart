import 'package:get/get.dart';
import 'package:qual_time/app/modules/teams/viewmodel/manage_teams_view_model.dart';

class ManageTeamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageTeamsViewModel>(() => ManageTeamsViewModel());
  }
}
