import 'package:flutter/material.dart';

import '../services/meal_service.dart';
import '../widgets/meal_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController searchController = TextEditingController(
    text: 'chicken',
  );

  final List<String> categories = const [
    'Seafood',
    'Chicken',
    'Beef',
    'Dessert',
    'Pasta',
    'Vegetarian',
    'Breakfast',
  ];

  void searchMeal() {
    dataService.searchByName(searchController.text);
  }

  void filterMeal(String category) {
    dataService.filterByCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Pesquisar'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Nome da comida',
                hintText: 'Ex: chicken, pasta, cake...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: searchMeal,
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: dataService.selectedCategoryNotifier,
                    builder: (_, selectedCategory, __) {
                      return DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            filterMeal(value);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: searchMeal,
                  child: const Text('Buscar'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ValueListenableBuilder(
              valueListenable: dataService.loadingNotifier,
              builder: (_, loading, __) {
                if (loading) {
                  return const LinearProgressIndicator();
                }

                return ValueListenableBuilder(
                  valueListenable: dataService.messageNotifier,
                  builder: (_, message, __) {
                    return Text(message);
                  },
                );
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ValueListenableBuilder(
                valueListenable: dataService.mealsNotifier,
                builder: (_, meals, __) {
                  if (meals.isEmpty) {
                    return const Center(
                      child: Text('Nenhum resultado para mostrar.'),
                    );
                  }

                  return ListView(
                    children: meals.map((meal) {
                      return MealCard(meal: meal);
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}