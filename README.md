# Cozinha Fácil

Mini-projeto desenvolvido em **Flutter/Dart** para a disciplina de **Programação Orientada a Objetos**.

O aplicativo consome dados da API pública **TheMealDB**, permitindo pesquisar receitas, filtrar por categoria, visualizar detalhes, favoritar receitas e abrir uma receita aleatória.

## Objetivo do projeto

O objetivo do projeto é aplicar conceitos trabalhados nas receitas da disciplina, como:

* Separação da interface dos componentes lógicos;
* Uso de API externa;
* Gerência de rotas;
* Gerência de estado;
* Uso de imagens;
* Formulário de pesquisa;
* Organização do código em arquivos e pastas;
* Criação de componentes reutilizáveis.

## Funcionalidades

O aplicativo possui as seguintes funcionalidades:

1. **Pesquisar receitas pelo nome**

   * O usuário digita o nome de uma comida e o app busca os dados na API.

2. **Filtrar receitas por categoria**

   * O usuário pode escolher categorias como `Chicken`, `Beef`, `Seafood`, `Dessert`, entre outras.

3. **Visualizar detalhes de uma receita**

   * Ao clicar em uma receita, o app mostra imagem, nome, categoria, origem e modo de preparo.

4. **Favoritar receitas**

   * O usuário pode adicionar ou remover receitas da lista de favoritas.

5. **Receita aleatória**

   * O app permite carregar uma receita aleatória diretamente da API.

## API utilizada

A API utilizada foi a **TheMealDB**.

Alguns endpoints usados no projeto:

* Pesquisa por nome:
  `https://www.themealdb.com/api/json/v1/1/search.php?s=chicken`

* Filtro por categoria:
  `https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood`

* Detalhes por ID:
  `https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772`

* Receita aleatória:
  `https://www.themealdb.com/api/json/v1/1/random.php`

## Tecnologias utilizadas

* Flutter
* Dart
* HTTP
* GetX

## Gerência de rotas

A gerência de rotas foi feita usando o pacote `get`.

As principais rotas do aplicativo são:

```dart
'/'          // Tela inicial
'/search'   // Tela de pesquisa
'/details'  // Tela de detalhes
'/favorites'// Tela de favoritas
```

## Gerência de estado

A gerência de estado foi feita usando `ValueNotifier` e `ValueListenableBuilder`.

Essa escolha permite atualizar apenas as partes necessárias da interface quando algum dado muda, evitando o uso de `StatefulWidget`.

Exemplos de estados usados no projeto:

* Lista de receitas;
* Receita selecionada;
* Lista de favoritas;
* Estado de carregamento;
* Mensagens para o usuário;
* Categoria selecionada.

## Organização do projeto

A estrutura principal do projeto está organizada da seguinte forma:

```txt
lib/
  main.dart
  models/
    meal.dart
  services/
    meal_service.dart
  pages/
    home_page.dart
    search_page.dart
    details_page.dart
    favorites_page.dart
  widgets/
    meal_card.dart
```

## Explicação das pastas

### `models`

Contém a classe `Meal`, responsável por representar uma receita dentro do aplicativo.

### `services`

Contém a classe `MealService`, responsável por consumir a API, processar os dados e controlar os estados do app.

### `pages`

Contém as telas principais do aplicativo:

* `home_page.dart`
* `search_page.dart`
* `details_page.dart`
* `favorites_page.dart`

### `widgets`

Contém componentes reutilizáveis da interface, como o `MealCard`.

## Como executar o projeto

Primeiro, instale as dependências:

```bash
flutter pub get
```

Depois execute o projeto:

```bash
flutter run
```

Para rodar diretamente no Chrome:

```bash
flutter run -d chrome
```

## Pacotes utilizados

Os pacotes externos usados foram:

```yaml
http
get
```

O pacote `http` foi utilizado para realizar as requisições à API.

O pacote `get` foi utilizado para a navegação entre telas.

## Observações

Os favoritos são armazenados em memória durante a execução do aplicativo. Ao fechar ou reiniciar o app, a lista de favoritos volta ao estado inicial.

O projeto utiliza uma API externa diferente das APIs usadas nas receitas de aula, mas mantém uma estrutura simples e próxima dos exemplos trabalhados na disciplina.

## Autor

Gabriel Uchoa
