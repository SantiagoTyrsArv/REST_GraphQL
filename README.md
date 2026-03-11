# 🌍 Country Explorer

Aplicación móvil desarrollada en Flutter que explora información geográfica
y cultural de los países del mundo, demostrando el consumo simultáneo de
REST y GraphQL en una misma app.

---

## 📱 Pantallas

| Pantalla | Tecnología | Descripción |
|---|---|---|
| **Países** | REST | Lista, búsqueda por nombre y filtro por región |
| **Detalle de País** | REST | Bandera, capital, región, subregión y población |
| **Continentes** | GraphQL | Continentes expandibles con países, idiomas y capitales |

---

## 🌐 APIs utilizadas

### REST — REST Countries API
- **Base URL:** `https://restcountries.com/v3.1`
- Sin autenticación requerida

| Endpoint | Descripción |
|---|---|
| `GET /all` | Todos los países |
| `GET /name/{name}` | Buscar por nombre |
| `GET /region/{region}` | Filtrar por región |

### GraphQL — Trevor Blades Countries API
- **Endpoint:** `https://countries.trevorblades.com/`
- Sin autenticación requerida

```graphql
query GetContinents {
  continents {
    code
    name
    countries {
      code
      name
      emoji
      capital
      languages {
        name
      }
    }
  }
}

📁 Estructura de carpetas
text
lib/
├── main.dart
├── core/
│   └── graphql_client.dart
├── datasources/
│   └── country_datasource.dart
├── models/
│   └── country.dart
├── services/
│   └── rest_service.dart
├── repository/
│   └── country_repository.dart
├── screens/
│   ├── home_screen.dart
│   ├── country_list_screen.dart
│   ├── country_detail_screen.dart
│   └── continent_screen.dart
└── widgets/
    ├── country_card.dart
    └── continent_countries_widget.dart
📦 Dependencias
text
dependencies:
  flutter:
    sdk: flutter
  http: ^1.6.0
  graphql_flutter: ^5.2.1
  cached_network_image: ^3.3.1
🚀 Instalación y ejecución
bash
# Clonar el repositorio
git clone https://github.com/usuario/country_explorer.git
cd country_explorer

# Instalar dependencias
flutter pub get

# Ejecutar la app
flutter run
Requisitos previos
Flutter SDK >= 3.0.0

Android SDK Platform 34

Android Studio

🆚 REST vs GraphQL — diferencia clave
REST	GraphQL
Llamadas para datos relacionados	Múltiples requests	Una sola query
Estructura de datos	Plana por recurso	Jerárquica y anidada
Uso en esta app	Países independientes	Continentes → países → idiomas
Over-fetching	Posible	Evitado — pides solo lo que necesitas
