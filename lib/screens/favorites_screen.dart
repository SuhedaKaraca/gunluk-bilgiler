import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/knowledge_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/knowledge_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<KnowledgeProvider>(context).favorites;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favori Bilgiler'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites added yet.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, i) => KnowledgeItem(favorites[i]),
            ),
    );
  }
}
