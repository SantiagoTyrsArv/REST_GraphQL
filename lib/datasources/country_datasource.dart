import '../models/country.dart';

abstract class CountryDataSource {
  Future<List<Country>> fetchAllCountries();
  Future<List<Country>> searchByName(String name);
  Future<List<Country>> fetchByRegion(String region);
}
