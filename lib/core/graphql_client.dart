import 'package:flutter/foundation.dart'; // ← este import faltaba
import 'package:graphql_flutter/graphql_flutter.dart';

final gqlClient = ValueNotifier(
  GraphQLClient(
    link: HttpLink('https://countries.trevorblades.com/'),
    cache: GraphQLCache(store: HiveStore()),
  ),
);
