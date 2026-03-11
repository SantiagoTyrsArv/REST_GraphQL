import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/rest_service.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen>
    with AutomaticKeepAliveClientMixin {
  final RestService _service = RestService();
  final TextEditingController _searchController = TextEditingController();

  late Future<List<Country>> _countriesFuture;
  String _selectedRegion = 'Todos';

  final List<String> _regions = [
    'Todos', 'Africa', 'Americas', 'Asia', 'Europe', 'Oceania',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _countriesFuture = _service.fetchAllCountries();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _countriesFuture = _service.fetchAllCountries();
      } else {
        _countriesFuture = _service.searchByName(query);
      }
    });
  }

  void _onRegionChanged(String? region) {
    if (region == null) return;
    setState(() {
      _selectedRegion = region;
      _searchController.clear();
      if (region == 'Todos') {
        _countriesFuture = _service.fetchAllCountries();
      } else {
        _countriesFuture = _service.fetchByRegion(region);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Buscar país...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedRegion,
                decoration: InputDecoration(
                  labelText: 'Filtrar por región',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                items: _regions
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: _onRegionChanged,
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Country>>(
            future: _countriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final countries = snapshot.data!;
              if (countries.isEmpty) {
                return const Center(child: Text('No se encontraron países.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  return CountryCard(
                    country: countries[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CountryDetailScreen(country: countries[index]),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
