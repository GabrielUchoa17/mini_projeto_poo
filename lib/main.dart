import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/details_page.dart';
import 'pages/favorites_page.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cozinha Fácil',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/search', page: () => SearchPage()),
        GetPage(name: '/details', page: () => const DetailsPage()),
        GetPage(name: '/favorites', page: () => const FavoritesPage()),
      ],
    ),
  );
}