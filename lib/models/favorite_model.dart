class FavoriteModel {
  final String imagePath;

  const FavoriteModel({required this.imagePath});

  static List<FavoriteModel> getFavoriteDatas() {
    List<FavoriteModel> favoriteDatas = [];

    for (int i = 0; i < 12; i++) {
      favoriteDatas.add(
        FavoriteModel(imagePath: 'images/recipe_thumbnail_2.png'),
      );
    }
    return favoriteDatas;
  }
}
