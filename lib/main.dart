import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'core/graphql_client.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const CountryExplorerApp());
}

class CountryExplorerApp extends StatelessWidget {
  const CountryExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gqlClient,
      child: MaterialApp(
        title: 'Country Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
