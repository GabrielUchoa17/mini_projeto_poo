import 'package:flutter/material.dart';

import '../services/meal_service.dart';
import '../widgets/meal_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Favoritas'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder(
          valueListenable: dataService.favoritesNotifier,
          builder: (_, favorites, __) {
            if (favorites.isEmpty) {
              return const Center(
                child: Text('Nenhuma receita favorita ainda.'),
              );
            }

            return ListView(
              children: favorites.map((meal) {
                return MealCard(meal: meal);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}