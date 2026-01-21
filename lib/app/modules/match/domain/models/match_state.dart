import 'package:qual_time/app/modules/match/domain/models/match_pair.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';

class MatchState {
  final MatchPair currentMatch;
  final List<Team> queue;
  final Team? restingTeam;

  MatchState({
    required this.currentMatch,
    required this.queue,
    this.restingTeam,
  });

  MatchState copyWith({
    MatchPair? currentMatch,
    List<Team>? queue,
    Team? restingTeam,
  }) {
    return MatchState(
      currentMatch: currentMatch ?? this.currentMatch,
      queue: queue ?? this.queue,
      restingTeam: restingTeam ?? this.restingTeam,
    );
  }
}
