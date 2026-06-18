import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/meal.dart';

class MealService {
  final ValueNotifier<List<Meal>> mealsNotifier = ValueNotifier([]);
  final ValueNotifier<Meal?> selectedMealNotifier = ValueNotifier(null);
  final ValueNotifier<List<Meal>> favoritesNotifier = ValueNotifier([]);
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);

  final ValueNotifier<String> messageNotifier = ValueNotifier(
    'Pesquise uma comida pelo nome ou filtre por categoria.',
  );

  final ValueNotifier<String> selectedCategoryNotifier = ValueNotifier(
    'Seafood',
  );

  Future<void> searchByName(String name) async {
    if (name.trim().isEmpty) {
      messageNotifier.value = 'Digite algum nome para pesquisar.';
      mealsNotifier.value = [];
      return;
    }

    loadingNotifier.value = true;

    final uri = Uri.https(
      'www.themealdb.com',
      '/api/json/v1/1/search.php',
      {'s': name},
    );

    try {
      final response = await http.get(uri);
      final data = jsonDecode(response.body);

      final List mealsJson = data['meals'] ?? [];

      mealsNotifier.value = mealsJson.map((mealJson) {
        return Meal.fromJson(mealJson);
      }).toList();

      if (mealsNotifier.value.isEmpty) {
        messageNotifier.value = 'Nenhuma comida encontrada.';
      } else {
        messageNotifier.value = '${mealsNotifier.value.length} resultado(s).';
      }
    } catch (erro) {
      messageNotifier.value = 'Erro ao buscar dados da API.';
      mealsNotifier.value = [];
    }

    loadingNotifier.value = false;
  }

  Future<void> filterByCategory(String category) async {
    loadingNotifier.value = true;
    selectedCategoryNotifier.value = category;

    final uri = Uri.https(
      'www.themealdb.com',
      '/api/json/v1/1/filter.php',
      {'c': category},
    );

    try {
      final response = await http.get(uri);
      final data = jsonDecode(response.body);

      final List mealsJson = data['meals'] ?? [];

      mealsNotifier.value = mealsJson.map((mealJson) {
        return Meal.fromJson(mealJson);
      }).toList();

      messageNotifier.value = 'Filtro aplicado: $category';
    } catch (erro) {
      messageNotifier.value = 'Erro ao filtrar por categoria.';
      mealsNotifier.value = [];
    }

    loadingNotifier.value = false;
  }

  Future<void> loadDetails(String id) async {
    loadingNotifier.value = true;

    final uri = Uri.https(
      'www.themealdb.com',
      '/api/json/v1/1/lookup.php',
      {'i': id},
    );

    try {
      final response = await http.get(uri);
      final data = jsonDecode(response.body);

      final List mealsJson = data['meals'] ?? [];

      if (mealsJson.isNotEmpty) {
        selectedMealNotifier.value = Meal.fromJson(mealsJson.first);
      }
    } catch (erro) {
      messageNotifier.value = 'Erro ao carregar detalhes.';
    }

    loadingNotifier.value = false;
  }

  Future<void> loadRandomMeal() async {
    loadingNotifier.value = true;
    selectedMealNotifier.value = null;

    final uri = Uri.https(
      'www.themealdb.com',
      '/api/json/v1/1/random.php',
    );

    try {
      final response = await http.get(uri);
      final data = jsonDecode(response.body);

      final List mealsJson = data['meals'] ?? [];

      if (mealsJson.isNotEmpty) {
        selectedMealNotifier.value = Meal.fromJson(mealsJson.first);
      }
    } catch (erro) {
      messageNotifier.value = 'Erro ao carregar comida aleatória.';
    }

    loadingNotifier.value = false;
  }

  void toggleFavorite(Meal meal) {
    final favorites = List<Meal>.from(favoritesNotifier.value);

    final alreadyExists = favorites.any((item) {
      return item.id == meal.id;
    });

    if (alreadyExists) {
      favorites.removeWhere((item) {
        return item.id == meal.id;
      });
    } else {
      favorites.add(meal);
    }

    favoritesNotifier.value = favorites;
  }

  bool isFavorite(String id) {
    return favoritesNotifier.value.any((meal) {
      return meal.id == id;
    });
  }
}

final MealService dataService = MealService();