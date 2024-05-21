import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/knowledge.dart';

class KnowledgeProvider with ChangeNotifier {
  Knowledge? _dailyKnowledge;
  List<Knowledge> _favorites = [];
  List<Knowledge> _allKnowledge = [];
  int _currentKnowledgeIndex = 0;
  String _selectedCategory = 'Genel Kültür';

  Knowledge? get dailyKnowledge => _dailyKnowledge;
  List<Knowledge> get favorites => _favorites;
  List<Knowledge> get allKnowledge => _allKnowledge;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchAllKnowledge() async {
    final String response =
        await rootBundle.loadString('assets/knowledge_data.json');
    final List<dynamic> data = json.decode(response);
    _allKnowledge = data
        .map((item) => Knowledge(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              category: item['category'],
            ))
        .toList();
    _dailyKnowledge =
        _allKnowledge.isNotEmpty ? _allKnowledge[_currentKnowledgeIndex] : null;
    notifyListeners();
  }

  void nextKnowledge() {
    if (_allKnowledge.isNotEmpty) {
      _currentKnowledgeIndex =
          (_currentKnowledgeIndex + 1) % _allKnowledge.length;
      _dailyKnowledge = _allKnowledge[_currentKnowledgeIndex];
      notifyListeners();
    }
  }

  Future<void> addToFavorites(Knowledge knowledge) async {
    _favorites.add(knowledge);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favorites', json.encode(_favorites));
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('favorites')) return;
    final extractedData =
        json.decode(prefs.getString('favorites')!) as List<dynamic>;
    _favorites = extractedData
        .map((item) => Knowledge(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              category: item['category'],
            ))
        .toList();
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Knowledge> getRecommendedKnowledge() {
    return _allKnowledge
        .where((knowledge) => knowledge.category == _selectedCategory)
        .toList();
  }
}
