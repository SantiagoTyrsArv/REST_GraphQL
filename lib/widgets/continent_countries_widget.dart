import 'package:flutter/material.dart';

class ContinentCountriesWidget extends StatefulWidget {
  final Map<String, dynamic> continent;
  const ContinentCountriesWidget({super.key, required this.continent});

  @override
  State<ContinentCountriesWidget> createState() =>
      _ContinentCountriesWidgetState();
}

class _ContinentCountriesWidgetState extends State<ContinentCountriesWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final countries = widget.continent['countries'] as List;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ExpansionTile(
        onExpansionChanged: (val) => setState(() => _expanded = val),
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            widget.continent['code'],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          widget.continent['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('${countries.length} países'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: const Text('GraphQL',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
              backgroundColor: Colors.teal,
              padding: EdgeInsets.zero,
            ),
            Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          ],
        ),
        children: countries.map<Widget>((c) {
          final languages = (c['languages'] as List)
              .map((l) => l['name'])
              .join(', ');
          return ListTile(
            leading: Text(c['emoji'] ?? '',
                style: const TextStyle(fontSize: 24)),
            title: Text(c['name']),
            subtitle: Text(
              '${c['capital'] ?? 'Sin capital'} • ${c['currency'] ?? 'N/A'}\n🗣 $languages',
            ),
            isThreeLine: true,
          );
        }).toList(),
      ),
    );
  }
}
