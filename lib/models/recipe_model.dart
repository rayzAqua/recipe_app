class RecipeModel {
  final String title;
  final String imagePath;
  final String authorName;
  final String cookTime;

  RecipeModel({
    required this.title,
    required this.imagePath,
    required this.authorName,
    required this.cookTime,
  });

  static List<RecipeModel> getRecipeDatas() {
    List<RecipeModel> recipeDatas = [];

    for (int i = 0; i < 3; i++) {
      recipeDatas.add(
        RecipeModel(
          title: "Trứng chiên",
          imagePath: 'images/recipe_thumbnail.png',
          authorName: 'Trần Đình Trọng',
          cookTime: '20 phút',
        ),
      );
    }

    return recipeDatas;
  }
}
