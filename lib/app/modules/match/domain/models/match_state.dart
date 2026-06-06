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

  factory MatchState.fromMap(Map<String, dynamic> map) {
    return MatchState(
      currentMatch: MatchPair.fromMap(
        Map<String, dynamic>.from(map['currentMatch'] as Map),
      ),
      queue:
          (map['queue'] as List? ?? const [])
              .map(
                (team) => Team.fromMap(Map<String, dynamic>.from(team as Map)),
              )
              .toList(),
      restingTeam:
          map['restingTeam'] == null
              ? null
              : Team.fromMap(
                Map<String, dynamic>.from(map['restingTeam'] as Map),
              ),
    );
  }

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

  Map<String, dynamic> toMap() {
    return {
      'currentMatch': currentMatch.toMap(),
      'queue': queue.map((team) => team.toMap()).toList(),
      'restingTeam': restingTeam?.toMap(),
    };
  }
}
