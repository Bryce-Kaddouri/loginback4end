class Train {
  String titre;
  String description;
  List<Tache> taches;

  Train({required this.titre, required this.description, required this.taches});

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      titre: json['titre'],
      description: json['description'],
      taches: json['taches'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'description': description,
      'taches': taches,
    };
  }

  @override
  String toString() {
    return 'Train{titre: $titre, description: $description, taches: $taches}';
  }
}

class Tache {
  String titre;
  String description;
  int timer;
  int poids;
  int repetition;

  Tache(
      {required this.titre,
      required this.description,
      required this.timer,
      required this.poids,
      required this.repetition});

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      titre: json['titre'],
      description: json['description'],
      timer: json['timer'],
      poids: json['poids'],
      repetition: json['repetition'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'description': description,
      'timer': timer,
      'poids': poids,
      'repetition': repetition,
    };
  }

  @override
  String toString() {
    return 'Tache{titre: $titre, description: $description, timer: $timer, poids: $poids, repetition: $repetition}';
  }
}
