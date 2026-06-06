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

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      name: map['name'] as String,
      wins: map['wins'] as int? ?? 0,
      losses: map['losses'] as int? ?? 0,
      consecutiveWins: map['consecutiveWins'] as int?,
      players: List<String>.from(map['players'] as List? ?? const []),
    );
  }

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'wins': wins,
      'losses': losses,
      'consecutiveWins': consecutiveWins,
      'players': players,
    };
  }
}
