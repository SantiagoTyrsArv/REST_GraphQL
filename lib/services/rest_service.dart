import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import '../datasources/country_datasource.dart';

/// Implementación REST de CountryDataSource.
/// Consume la REST Countries API v3.1.
class RestService implements CountryDataSource {
  static const String _base = 'https://restcountries.com/v3.1';
  static const String _fields =
      'fields=name,cca2,region,subregion,population,capital,flags,flag';

  @override
  Future<List<Country>> fetchAllCountries() async {
    final response = await http.get(Uri.parse('$_base/all?$_fields'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      countries.sort((a, b) => a.name.compareTo(b.name));
      return countries;
    }
    throw Exception('Error REST: ${response.statusCode}');
  }

  @override
  Future<List<Country>> searchByName(String name) async {
    final response =
    await http.get(Uri.parse('$_base/name/$name?$_fields'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Country.fromJson(e)).toList();
    }
    if (response.statusCode == 404) return [];
    throw Exception('Error REST: ${response.statusCode}');
  }

  @override
  Future<List<Country>> fetchByRegion(String region) async {
    final response =
    await http.get(Uri.parse('$_base/region/$region?$_fields'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      countries.sort((a, b) => a.name.compareTo(b.name));
      return countries;
    }
    throw Exception('Error REST: ${response.statusCode}');
  }
}
