class SearchResultModel {
  final String title;
  final String imagePath;
  final String authorName;
  final String length;

  const SearchResultModel({
    required this.title,
    required this.imagePath,
    required this.authorName,
    required this.length,
  });

  static List<SearchResultModel> getSearchResultDatas() {
    List<SearchResultModel> searchResultDatas = [];

    for (int i = 0; i < 4; i++) {
      searchResultDatas.add(
        SearchResultModel(
          title: 'Salad bò kiểu Thái',
          imagePath: 'images/result_thumbnail.png',
          authorName: 'Little Pony',
          length: '20m',
        ),
      );
    }

    return searchResultDatas;
  }
}
