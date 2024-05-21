import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/knowledge_provider.dart';
import './providers/theme_provider.dart';
import './screens/home_screen.dart';
import './screens/favorites_screen.dart';
import './screens/recommended_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => KnowledgeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Günlük Bilgiler',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: themeProvider.themeMode,
            home: HomeScreen(),
            routes: {
              '/favorites': (ctx) => FavoritesScreen(),
              '/recommended': (ctx) => RecommendedScreen(),
            },
          );
        },
      ),
    );
  }
}
