import 'dart:async';

import 'package:get/get.dart';
import 'package:qual_time/app/core/models/game_engine.dart';
import 'package:qual_time/app/core/services/local_storage_service_interface.dart';
import 'package:qual_time/app/modules/match/domain/models/match_pair.dart';
import 'package:qual_time/app/modules/match/domain/models/match_state.dart';
import 'package:qual_time/app/modules/match/domain/models/team.dart';
import 'package:qual_time/app/modules/teams/viewmodel/manage_teams_view_model.dart';

class MatchViewModel extends GetxController {
  static const _currentMatchStorageKey = 'current_match_state';

  final ManageTeamsViewModel _manageTeamsViewModel = Get.find();
  final ILocalStorageService? _localStorageService =
      Get.isRegistered<ILocalStorageService>()
          ? Get.find<ILocalStorageService>()
          : null;

  final _state = Rxn<MatchState>();

  final GameEngine _engine = GameEngine();

  MatchState? get state => _state.value;

  MatchPair? get currentMatch => state?.currentMatch;

  Team? get restingTeam => state?.restingTeam;

  int get teamCount => _manageTeamsViewModel.teams.length;

  List<Team> get teams =>
      state?.currentMatch == null
          ? []
          : [
            state!.currentMatch.left,
            state!.currentMatch.right,
            ...(state?.restingTeam == null ? [] : [state!.restingTeam!]),
            ...state!.queue,
          ];

  @override
  void onInit() {
    super.onInit();
    unawaited(_loadPersistedState());
    ever<MatchState?>(_state, (state) {
      unawaited(_persistState(state));
    });
  }

  void startMatch() {
    final List<Team> queue = List.from(_manageTeamsViewModel.teams);

    final Team left = queue.removeAt(0);
    final Team right = queue.removeAt(0);

    _state.value = MatchState(
      currentMatch: MatchPair(left: left, right: right),
      queue: queue,
      restingTeam: null,
    );
  }

  void onTeamWon(String teamId) {
    if (_state.value == null) return;
    _state.value = _engine.registerWin(
      state: _state.value!,
      winnerTeamId: teamId,
    );
  }

  void swapTeams() {
    if (_state.value == null) return;
    final currentState = _state.value!;
    final currentMatch = currentState.currentMatch;

    final newMatch = MatchPair(
      left: currentMatch.right,
      right: currentMatch.left,
    );

    _state.value = currentState.copyWith(currentMatch: newMatch);
  }

  void resetMatch() {
    _state.value = null;
  }

  Future<void> _loadPersistedState() async {
    final persistedState = await _localStorageService?.get(
      _currentMatchStorageKey,
    );

    if (persistedState == null || persistedState.isEmpty) return;

    _state.value = MatchState.fromMap(persistedState);
  }

  Future<void> _persistState(MatchState? state) async {
    await _localStorageService?.set(
      _currentMatchStorageKey,
      state?.toMap() ?? <String, dynamic>{},
    );
  }
}
