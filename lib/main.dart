import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'core/graphql_client.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const CountryExplorerApp());
}

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get mode => _mode;

  void toggle() {
    _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

final themeNotifier = ThemeNotifier();

class CountryExplorerApp extends StatelessWidget {
  const CountryExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gqlClient,
      child: AnimatedBuilder(
        animation: themeNotifier,
        builder: (context, _) {
          return MaterialApp(
            title: 'Country Explorer',
            debugShowCheckedModeBanner: false,
            themeMode: themeNotifier.mode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

class AppTheme {
  static const _primaryLight = Color(0xFF0077B6);
  static const _primaryDark = Color(0xFF00B4D8);
  static const _bgLight = Color(0xFFF0F4F8);
  static const _bgDark = Color(0xFF0D1B2A);
  static const _surfaceLight = Color(0xFFFFFFFF);
  static const _surfaceDark = Color(0xFF1B2E3C);

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _bgLight,
    colorScheme: ColorScheme.light(
      primary: _primaryLight,
      secondary: const Color(0xFF00B4D8),
      background: _bgLight,
      surface: _surfaceLight,
      onPrimary: Colors.white,
      onBackground: const Color(0xFF0D1B2A),
      onSurface: const Color(0xFF0D1B2A),
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: _surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bgDark,
    colorScheme: ColorScheme.dark(
      primary: _primaryDark,
      secondary: const Color(0xFF90E0EF),
      background: _bgDark,
      surface: _surfaceDark,
      onPrimary: _bgDark,
      onBackground: const Color(0xFFE0F7FA),
      onSurface: const Color(0xFFE0F7FA),
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: _bgDark,
      foregroundColor: Color(0xFFE0F7FA),
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: _surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}
