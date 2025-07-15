class FilterModel {
  final List<String>? categories;
  final List<String>? ingredients;
  final List<String>? locations;

  FilterModel({this.categories, this.ingredients, this.locations});
}

class CategoryModel {
  final List<String> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(List<dynamic> json) {
    List<String> allCategory = [];
    for (var data in json) {
      final category = data['strCategory'];
      if (category != null && category.toString().trim().isNotEmpty) {
        allCategory.add(category.toString().trim());
      }
    }
    return CategoryModel(categories: allCategory);
  }
}

class IngredientModel {
  final List<String> ingredients;

  IngredientModel({required this.ingredients});

  factory IngredientModel.fromJson(List<dynamic> json) {
    List<String> allIngredient = [];
    for (var data in json) {
      final ingredient = data['strIngredient'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        allIngredient.add(ingredient.toString().trim());
      }
    }
    return IngredientModel(ingredients: allIngredient);
  }
}

class LocationModel {
  final List<String> locations;

  LocationModel({required this.locations});

  factory LocationModel.fromJson(List<dynamic> json) {
    List<String> allLocation = [];
    for (var data in json) {
      final location = data['strArea'];
      if (location != null && location.toString().trim().isNotEmpty) {
        allLocation.add(location.toString().trim());
      }
    }
    return LocationModel(locations: allLocation);
  }
}

class FilterResultModel {
  final String category;
  final List<String> ingredients;
  final String location;

  const FilterResultModel(this.category, this.ingredients, this.location);
}
