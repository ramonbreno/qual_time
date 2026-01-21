import 'package:qual_time/app/modules/match/domain/models/match_pair.dart';
import 'package:qual_time/app/modules/match/domain/models/match_state.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';

MatchState initialMatchState(List<Team> teams) {
  assert(
    teams.length >= 2,
    "É necessário pelo menos 2 times para iniciar o jogo",
  );

  final List<Team> queue = teams;

  final Team left = queue.removeAt(0);
  final Team right = queue.removeAt(0);

  return MatchState(
    currentMatch: MatchPair(left: left, right: right),
    queue: queue,
    restingTeam: null,
  );
}
