import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/country.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const CountryCard({super.key, required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: country.flagUrl,
            width: 56,
            height: 40,
            fit: BoxFit.cover,
            placeholder: (_, __) => const SizedBox(
              width: 56,
              height: 40,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (_, __, ___) =>
                Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
          ),
        ),
        title: Text(
          country.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${country.capitalDisplay} • ${country.region}'),
        trailing: const Icon(Icons.chevron_right, color: Colors.indigo),
        onTap: onTap,
      ),
    );
  }
}
