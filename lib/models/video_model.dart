import 'package:hive_flutter/hive_flutter.dart';

class VideoModel {
  final String id;
  final String videoTitle;
  final String category;
  final String area;
  final String instructions;
  final String videoPath;
  final List<String> mainIngredients;
  final List<String> measures;
  String videoLength;
  List<String> images = [
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
    'images/video_thumbnail.png',
  ];
  String authorName;
  String authorAvatarPath;
  bool isFavorite;
  double rating;
  double ratingVoteQuality = 120;

  VideoModel({
    required this.id,
    required this.category,
    required this.area,
    required this.instructions,
    required this.videoTitle,
    required this.videoPath,
    required this.mainIngredients,
    required this.measures,
    this.videoLength = '1 tiếng 20 phút',
    this.authorName = 'Đinh Trọng Phúc',
    this.authorAvatarPath = 'images/user_avatar.png',
    this.rating = 5.0,
    this.isFavorite = false,
  });

  final mybox = Hive.box('recipesApp');

  void getFavoriteData() {
    isFavorite = mybox.get('FAVORITE_$id', defaultValue: false);
  }

  static List<VideoModel> getAllFavoriteVideos() {
    final box = Hive.box('recipesApp');
    final keys = box.keys;

    final favoriteIds = keys
        .where((key) => key.toString().startsWith('VIDEO_'))
        .map((key) => key.toString().replaceFirst('VIDEO_', ''))
        .toList();

    return favoriteIds.map((id) {
      return VideoModel(
        id: box.get('VIDEO_$id'),
        videoTitle: box.get('TITLE_$id') ?? '',
        videoPath: box.get('PATH_$id') ?? '',
        videoLength: box.get('LENGTH_$id') ?? 'Không rõ thời lượng',
        authorName: box.get('AUTHOR_$id') ?? '',
        authorAvatarPath: box.get('AVATAR_$id') ?? '',
        rating: box.get('RATING_$id') ?? 0.0,
        isFavorite: box.get('FAVORITE_$id'),
        category: '',
        area: '',
        instructions: box.get('INSTRUCTION_$id'),
        mainIngredients: box.get('INGREDIENT_$id'),
        measures: box.get('MEASURE_$id'),
      );
    }).toList();
  }

  void updateFavoriteData() {
    isFavorite = !isFavorite;
    mybox.put('FAVORITE_$id', isFavorite);
    if (isFavorite) {
      mybox.put('VIDEO_$id', id);
      mybox.put('TITLE_$id', videoTitle);
      mybox.put('PATH_$id', videoPath);
      mybox.put('LENGTH_$id', videoLength);
      mybox.put('AUTHOR_$id', authorName);
      mybox.put('AVATAR_$id', authorAvatarPath);
      mybox.put('RATING_$id', rating);
      mybox.put('INGREDIENT_$id', mainIngredients);
      mybox.put('MEASURE_$id', measures);
      mybox.put('INSTRUCTION_$id', instructions);
    } else {
      mybox.delete('VIDEO_$id');
      mybox.delete('TITLE_$id');
      mybox.delete('PATH_$id');
      mybox.delete('LENGTH_$id');
      mybox.delete('AUTHOR_$id');
      mybox.delete('AVATAR_$id');
      mybox.delete('RATING_$id');
      mybox.delete('INGREDIENT_$id');
      mybox.delete('MEASURE_$id');
      mybox.delete('INSTRUCTION_$id');
    }
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    List<String> allIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        allIngredients.add(ingredient.toString().trim());
      }
    }
    List<String> allMeasures = [];
    for (int i = 1; i <= 20; i++) {
      final measure = json['strMeasure$i'];
      if (measure != null && measure.toString().trim().isNotEmpty) {
        allMeasures.add(measure.toString().trim());
      }
    }

    return VideoModel(
      id: json['idMeal'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      videoTitle: json['strMeal'],
      videoPath: json['strMealThumb'],
      mainIngredients: allIngredients,
      measures: allMeasures,
    );
  }
}
