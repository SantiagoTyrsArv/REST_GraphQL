import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../widgets/continent_countries_widget.dart';

const String _continentsQuery = r"""
  query GetContinents {
    continents {
      code
      name
      countries {
        code
        name
        emoji
        capital
        currency
        languages {
          name
        }
      }
    }
  }
""";

class ContinentScreen extends StatefulWidget {
  const ContinentScreen({super.key});

  @override
  State<ContinentScreen> createState() => _ContinentScreenState();
}

class _ContinentScreenState extends State<ContinentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Query(
      options: QueryOptions(
        document: gql(_continentsQuery),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (result.hasException) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text('Error: ${result.exception.toString()}'),
                ElevatedButton(
                  onPressed: refetch,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        final continents = result.data!['continents'] as List;

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: continents.length,
          itemBuilder: (context, index) {
            final continent = continents[index];
            return ContinentCountriesWidget(continent: continent);
          },
        );
      },
    );
  }
}
