class Country {
  final String name;
  final String cca2;
  final String region;
  final String subregion;
  final int population;
  final List<String> capitals;
  final String flagUrl;
  final String flagEmoji;

  Country({
    required this.name,
    required this.cca2,
    required this.region,
    required this.subregion,
    required this.population,
    required this.capitals,
    required this.flagUrl,
    required this.flagEmoji,
  });

  // capital puede ser null en la API
  String get capitalDisplay =>
      capitals.isNotEmpty ? capitals.first : 'Sin capital';

  factory Country.fromJson(Map<String, dynamic> json) {
    final flags = json['flags'] as Map<String, dynamic>? ?? {};
    final capitals = (json['capital'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ??
        [];

    return Country(
      name: json['name']['common'] ?? '',
      cca2: json['cca2'] ?? '',
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      population: json['population'] ?? 0,
      capitals: capitals,
      flagUrl: flags['png'] ?? '',
      flagEmoji: json['flag'] ?? '',
    );
  }
}
