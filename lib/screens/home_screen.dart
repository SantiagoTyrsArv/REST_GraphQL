import 'package:flutter/material.dart';
import '../main.dart';
import 'country_list_screen.dart';
import 'continent_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🌍', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 10),
              const Text(
                'Country Explorer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: themeNotifier.toggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        size: 18,
                        color: primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isDark ? 'Light' : 'Dark',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: primary,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: primary,
            unselectedLabelColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(icon: Icon(Icons.public), text: 'Países'),
              Tab(icon: Icon(Icons.hub_outlined), text: 'Continentes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CountryListScreen(),
            ContinentScreen(),
          ],
        ),
      ),
    );
  }
}
