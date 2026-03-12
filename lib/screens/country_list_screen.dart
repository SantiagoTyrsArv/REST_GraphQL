import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/country.dart';
import '../repository/country_repository.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen>
    with AutomaticKeepAliveClientMixin {
  final CountryRepository _repository = CountryRepository();
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
    _countriesFuture = _repository.getAllCountries();
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _countriesFuture = _repository.getAllCountries();
      } else {
        _countriesFuture = _repository.searchByName(query);
      }
    });
  }

  void _onRegionChanged(String? region) {
    if (region == null) return;
    setState(() {
      _selectedRegion = region;
      _searchController.clear();
      if (region == 'Todos') {
        _countriesFuture = _repository.getAllCountries();
      } else {
        _countriesFuture = _repository.getByRegion(region);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: primary.withOpacity(0.2), width: 1),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearch,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Buscar país...',
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.4)),
                        prefixIcon: Icon(Icons.search, color: primary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: primary.withOpacity(0.2), width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRegion,
                        isExpanded: true,
                        dropdownColor: isDark
                            ? const Color(0xFF1B2E3C)
                            : Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: primary),
                        items: _regions
                            .map((r) => DropdownMenuItem(
                            value: r,
                            child: Text(r,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface))))
                            .toList(),
                        onChanged: _onRegionChanged,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Country>>(
            future: _countriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: primary),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: primary.withOpacity(0.6)),
                      const SizedBox(height: 8),
                      Text(
                        'Error al cargar países',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground),
                      ),
                    ],
                  ),
                );
              }
              final countries = snapshot.data!;
              if (countries.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔍',
                          style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 8),
                      Text(
                        'No se encontraron países',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  return CountryCard(
                    country: countries[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CountryDetailScreen(
                            country: countries[index]),
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
