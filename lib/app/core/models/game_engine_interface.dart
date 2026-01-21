import 'package:qual_time/app/modules/match/domain/models/match_state.dart';

abstract class GameEngineInterface {
  MatchState registerWin({
    required MatchState state,
    required String winnerTeamId,
  });
}
