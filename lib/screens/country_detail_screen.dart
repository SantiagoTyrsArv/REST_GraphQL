import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/country.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: country.flagUrl,
                  width: 220,
                  height: 140,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                  const CircularProgressIndicator(),
                  errorWidget: (_, __, ___) =>
                  const Icon(Icons.flag, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _InfoRow(label: 'Nombre oficial', value: country.name),
            _InfoRow(label: 'Código', value: country.cca2),
            _InfoRow(label: 'Capital', value: country.capitalDisplay),
            _InfoRow(label: 'Región', value: country.region),
            _InfoRow(label: 'Subregión', value: country.subregion),
            _InfoRow(
              label: 'Población',
              value: _formatPopulation(country.population),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Text('Fuente: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('REST Countries API  '),
                  const Spacer(),
                  Chip(
                    label: const Text('REST',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.indigo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPopulation(int pop) {
    if (pop >= 1000000) return '${(pop / 1000000).toStringAsFixed(1)}M';
    if (pop >= 1000) return '${(pop / 1000).toStringAsFixed(0)}K';
    return pop.toString();
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.indigo)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
