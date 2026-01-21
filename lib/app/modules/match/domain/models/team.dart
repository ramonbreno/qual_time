class Team {
  final String id;
  final String name;
  final int wins;
  final int losses;
  final int? consecutiveWins;

  final List<String> players;

  Team({
    required this.id,
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.consecutiveWins,
    this.players = const [],
  });

  Team copyWith({
    String? id,
    String? name,
    int? wins,
    int? losses,
    int? consecutiveWins,
    List<String>? players,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      consecutiveWins: consecutiveWins ?? this.consecutiveWins,
      players: players ?? this.players,
    );
  }
}
