import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  // Changing the original list is not allowed in Riverpod, so we create a new list
  // whenever we want to update the state.
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      // if favorites meals list already contains the meal, we leave that one out
      // and create a new list with the remaining meals
      return false;
    } else {
      state = [...state, meal];
      // if the meal is not in the favorites list, we add it to the list but to a new one not original one
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
