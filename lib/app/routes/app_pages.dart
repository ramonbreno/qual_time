import 'package:get/get.dart';
import 'package:qual_time/app/modules/main/ui/main_page.dart';
import 'package:qual_time/app/modules/main/ui/root_binding.dart';
import 'package:qual_time/app/modules/match/ui/match_page.dart';
import 'package:qual_time/app/modules/ranking/ui/ranking_page.dart';
import 'package:qual_time/app/modules/teams/ui/add_team_page.dart';
import 'package:qual_time/app/modules/teams/ui/manage_teams_page.dart';
import 'package:qual_time/app/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const MainPage(),
      binding: RootBinding(),
      children: [
        GetPage(name: Routes.match, page: () => const MatchPage()),
        GetPage(name: Routes.teams, page: () => const ManageTeamsPage()),
        GetPage(name: Routes.ranking, page: () => const RankingPage()),
      ],
    ),
    GetPage(name: Routes.addTeam, page: () => const AddTeamPage()),
  ];
}
