import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/meal.dart';
import '../services/meal_service.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({
    super.key,
    required this.meal,
  });

  void openDetails() {
    dataService.selectedMealNotifier.value = meal;
    dataService.loadDetails(meal.id);
    Get.toNamed('/details');
  }

  void favoriteMeal() {
    dataService.toggleFavorite(meal);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: InkWell(
        onTap: openDetails,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(4),
              ),
              child: Image.network(
                meal.image,
                width: 105,
                height: 105,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 105,
                    height: 105,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  meal.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  meal.category.isEmpty
                      ? 'Toque para ver detalhes'
                      : meal.category,
                ),
                trailing: ValueListenableBuilder(
                  valueListenable: dataService.favoritesNotifier,
                  builder: (_, favorites, __) {
                    final favorite = favorites.any((item) {
                      return item.id == meal.id;
                    });

                    return IconButton(
                      onPressed: favoriteMeal,
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        color: favorite ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}