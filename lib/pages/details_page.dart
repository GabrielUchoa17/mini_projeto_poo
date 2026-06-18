import 'package:flutter/material.dart';

import '../services/meal_service.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  void favoriteSelectedMeal() {
    final meal = dataService.selectedMealNotifier.value;

    if (meal != null) {
      dataService.toggleFavorite(meal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
        valueListenable: dataService.selectedMealNotifier,
        builder: (_, meal, __) {
          if (meal == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  meal.image,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Chip(
                    label: Text(
                      meal.category.isEmpty ? 'Sem categoria' : meal.category,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(
                      meal.area.isEmpty ? 'Origem desconhecida' : meal.area,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ValueListenableBuilder(
                valueListenable: dataService.favoritesNotifier,
                builder: (_, favorites, __) {
                  final favorite = favorites.any((item) {
                    return item.id == meal.id;
                  });

                  return ElevatedButton.icon(
                    onPressed: favoriteSelectedMeal,
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      favorite
                          ? 'Remover dos favoritos'
                          : 'Adicionar aos favoritos',
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Modo de preparo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                meal.instructions.isEmpty
                    ? 'Carregando ou sem instruções disponíveis.'
                    : meal.instructions,
                textAlign: TextAlign.justify,
              ),
            ],
          );
        },
      ),
    );
  }
}