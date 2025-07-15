class RecentlyModel {
  String title;
  String imagePath;
  String authorName;
  String authorAvatarPath;

  RecentlyModel({
    required this.title,
    required this.imagePath,
    required this.authorName,
    required this.authorAvatarPath,
  });

  static List<RecentlyModel> getRecentlyDatas() {
    List<RecentlyModel> recentlyDatas = [];

    for (int i = 0; i < 3; i++) {
      recentlyDatas.add(
        RecentlyModel(
          title: 'Trứng chiên',
          imagePath: 'images/recipe_thumbnail_2.png',
          authorName: 'Nguyễn Đình Trọng',
          authorAvatarPath: 'images/user_avatar_2.png',
        ),
      );
    }
    return recentlyDatas;
  }
}
