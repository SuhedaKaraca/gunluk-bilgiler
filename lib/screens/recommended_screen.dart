import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/knowledge_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/knowledge_item.dart';

class RecommendedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final knowledgeProvider = Provider.of<KnowledgeProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final categories = ['Spor', 'Uzay', 'Yazılım', 'Seyahat', 'Genel Kültür'];
    final recommendations = knowledgeProvider.getRecommendedKnowledge();

    return Scaffold(
      appBar: AppBar(
        title: Text('Türlere Göre Bilgiler'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: knowledgeProvider.selectedCategory,
              onChanged: (String? newValue) {
                knowledgeProvider.setCategory(newValue!);
              },
              items:
                  categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: recommendations.isEmpty
                ? Center(child: Text('No recommendations available.'))
                : ListView.builder(
                    itemCount: recommendations.length,
                    itemBuilder: (ctx, i) => KnowledgeItem(recommendations[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
