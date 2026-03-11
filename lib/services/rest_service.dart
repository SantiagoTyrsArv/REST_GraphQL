import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class RestService {
  static const String _base = 'https://restcountries.com/v3.1';

  // Todos los países con campos limitados (máx 10 por restricción de la API)
  Future<List<Country>> fetchAllCountries() async {
    final uri = Uri.parse(
      '$_base/all?fields=name,cca2,region,subregion,population,capital,flags,flag',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      countries.sort((a, b) => a.name.compareTo(b.name));
      return countries;
    }
    throw Exception('Error REST: ${response.statusCode}');
  }

  // Buscar por nombre
  Future<List<Country>> searchByName(String name) async {
    final uri = Uri.parse(
      '$_base/name/$name?fields=name,cca2,region,subregion,population,capital,flags,flag',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Country.fromJson(e)).toList();
    }
    if (response.statusCode == 404) return [];
    throw Exception('Error REST: ${response.statusCode}');
  }

  // Filtrar por región
  Future<List<Country>> fetchByRegion(String region) async {
    final uri = Uri.parse(
      '$_base/region/$region?fields=name,cca2,region,subregion,population,capital,flags,flag',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final countries = data.map((e) => Country.fromJson(e)).toList();
      countries.sort((a, b) => a.name.compareTo(b.name));
      return countries;
    }
    throw Exception('Error REST: ${response.statusCode}');
  }
}
