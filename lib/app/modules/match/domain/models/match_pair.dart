import 'package:qual_time/app/modules/match/domain/models/team.dart';

class MatchPair {
  final Team left;
  final Team right;

  MatchPair({required this.left, required this.right});

  factory MatchPair.fromMap(Map<String, dynamic> map) {
    return MatchPair(
      left: Team.fromMap(Map<String, dynamic>.from(map['left'] as Map)),
      right: Team.fromMap(Map<String, dynamic>.from(map['right'] as Map)),
    );
  }

  Map<String, dynamic> toMap() {
    return {'left': left.toMap(), 'right': right.toMap()};
  }
}
