import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/knowledge.dart';
import '../providers/knowledge_provider.dart';

class KnowledgeItem extends StatelessWidget {
  final Knowledge knowledge;

  KnowledgeItem(this.knowledge);

  @override
  Widget build(BuildContext context) {
    final knowledgeProvider =
        Provider.of<KnowledgeProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              knowledge.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(knowledge.description),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    knowledgeProvider.addToFavorites(knowledge);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
