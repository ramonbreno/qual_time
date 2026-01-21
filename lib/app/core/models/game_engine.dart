import 'package:qual_time/app/core/models/game_engine_interface.dart';
import 'package:qual_time/app/modules/match/domain/models/match_pair.dart';
import 'package:qual_time/app/modules/match/domain/models/match_state.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';

class GameEngine implements GameEngineInterface {
  static const int maxConsecutiveWins = 2;

  @override
  MatchState registerWin({
    required MatchState state,
    required String winnerTeamId,
  }) {
    final left = state.currentMatch.left;
    final right = state.currentMatch.right;

    final bool leftWon = left.id == winnerTeamId;

    final Team winner = leftWon ? left : right;
    final Team loser = leftWon ? right : left;

    final Team newWinner = winner.copyWith(
      consecutiveWins: (winner.consecutiveWins ?? 0) + 1,
      wins: winner.wins + 1,
    );

    final Team updateLoser = loser.copyWith(
      consecutiveWins: 0,
      losses: loser.losses + 1,
    );

    final List<Team> updateQueue = List.of(state.queue)..add(updateLoser);

    if ((newWinner.consecutiveWins ?? 0) >= maxConsecutiveWins) {
      final Team newRestingTeam = newWinner.copyWith(consecutiveWins: 0);

      final Team nextA = updateQueue.removeAt(0);
      final Team nextB = updateQueue.removeAt(0);

      return MatchState(
        currentMatch: MatchPair(left: nextA, right: nextB),
        queue: updateQueue,
        restingTeam: newRestingTeam,
      );
    }

    if (state.restingTeam != null) {
      final Team returningTeam = state.restingTeam!;

      return MatchState(
        currentMatch: MatchPair(left: newWinner, right: returningTeam),
        queue: updateQueue,
        restingTeam: null,
      );
    }

    final Team nextTeam = updateQueue.removeAt(0);

    return MatchState(
      currentMatch: MatchPair(left: newWinner, right: nextTeam),
      queue: updateQueue,
      restingTeam: null,
    );
  }
}
