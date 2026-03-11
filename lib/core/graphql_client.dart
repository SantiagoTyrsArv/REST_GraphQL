import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// GraphQLClient se instancia una sola vez y se reutiliza
class GraphQLClientSingleton {
  static final GraphQLClientSingleton _instance =
  GraphQLClientSingleton._internal();

  factory GraphQLClientSingleton() => _instance;
  GraphQLClientSingleton._internal();

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://countries.trevorblades.com/'),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
}

// Acceso directo para usar en GraphQLProvider
final gqlClient = GraphQLClientSingleton().client;
