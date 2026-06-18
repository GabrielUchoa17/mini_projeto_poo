import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/meal_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openSearch() {
    Get.toNamed('/search');
  }

  void openFavorites() {
    Get.toNamed('/favorites');
  }

  Future<void> openRandomMeal() async {
    await dataService.loadRandomMeal();
    Get.toNamed('/details');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Cozinha Fácil'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    size: 70,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Encontre receitas usando dados de uma API',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Pesquise comidas, filtre por categoria, veja detalhes e salve suas favoritas.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: openSearch,
                    icon: const Icon(Icons.search),
                    label: const Text('Pesquisar receitas'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: openRandomMeal,
                    icon: const Icon(Icons.casino),
                    label: const Text('Receita aleatória'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: openFavorites,
                    icon: const Icon(Icons.favorite),
                    label: const Text('Ver favoritas'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}