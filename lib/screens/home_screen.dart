import 'package:flutter/material.dart';
import 'country_list_screen.dart';
import 'continent_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          title: const Row(
            children: [
              Text('🌍', style: TextStyle(fontSize: 22)),
              SizedBox(width: 8),
              Text('Country Explorer'),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.public), text: 'Países (REST)'),
              Tab(icon: Icon(Icons.hub), text: 'Continentes (GraphQL)'),
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
