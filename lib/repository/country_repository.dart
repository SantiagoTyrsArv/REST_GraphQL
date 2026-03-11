import '../models/country.dart';
import '../datasources/country_datasource.dart';
import '../services/rest_service.dart';

class CountryRepository {
  // Instancia única privada
  static final CountryRepository _instance = CountryRepository._internal();
  factory CountryRepository() => _instance;
  CountryRepository._internal();

  final CountryDataSource _dataSource = RestService();

  //Map usado como caché por región
  final Map<String, List<Country>> _cache = {};

  // Lista ordenada alfabéticamente de todos los países
  List<Country> _allCountries = [];

  Future<List<Country>> getAllCountries() async {
    if (_allCountries.isNotEmpty) return _allCountries;
    _allCountries = await _dataSource.fetchAllCountries();
    return _allCountries;
  }

  Future<List<Country>> getByRegion(String region) async {
    if (_cache.containsKey(region)) {
      return _cache[region]!;
    }
    final result = await _dataSource.fetchByRegion(region);
    _cache[region] = result; // guarda en el Map
    return result;
  }

  Future<List<Country>> searchByName(String name) async {
    // Búsqueda local sobre la lista ya cargada
    if (_allCountries.isNotEmpty) {
      final query = name.toLowerCase();
      return _allCountries
          .where((c) => c.name.toLowerCase().contains(query))
          .toList();
    }
    // Si aún no está cargada, consulta la API
    return _dataSource.searchByName(name);
  }

  /// Búsqueda binaria por nombre exacto sobre la lista ordenada.
  Country? binarySearchByName(String name) {
    if (_allCountries.isEmpty) return null;
    int low = 0;
    int high = _allCountries.length - 1;

    while (low <= high) {
      final mid = (low + high) ~/ 2;
      final cmp = _allCountries[mid].name.toLowerCase()
          .compareTo(name.toLowerCase());
      if (cmp == 0) return _allCountries[mid];
      if (cmp < 0) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return null;
  }

  // Limpia el caché si se necesita forzar recarga
  void clearCache() {
    _cache.clear();
    _allCountries = [];
  }
}


