import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/knowledge_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/knowledge_item.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<KnowledgeProvider>(context, listen: false)
          .fetchAllKnowledge();
      Provider.of<KnowledgeProvider>(context, listen: false).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final knowledgeProvider = Provider.of<KnowledgeProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final random = Random();
    final dailyKnowledge = knowledgeProvider.allKnowledge.isNotEmpty
        ? knowledgeProvider
            .allKnowledge[random.nextInt(knowledgeProvider.allKnowledge.length)]
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük Bilgiler'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).pushNamed('/favorites');
            },
          ),
          IconButton(
            icon: Icon(Icons.recommend),
            onPressed: () {
              Navigator.of(context).pushNamed('/recommended');
            },
          ),
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
      body: dailyKnowledge == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: KnowledgeItem(dailyKnowledge)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      knowledgeProvider.nextKnowledge();
                    },
                    child: Text('Yeni Bir Bilgi İstiyorum'),
                  ),
                ),
              ],
            ),
    );
  }
}
