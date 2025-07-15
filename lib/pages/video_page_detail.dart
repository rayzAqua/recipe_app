import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pratical_flutter/models/video_model.dart';

class VideoPageDetail extends StatefulWidget {
  final VideoModel videoModel;

  const VideoPageDetail({super.key, required this.videoModel});

  @override
  State<VideoPageDetail> createState() => _VideoPageDetailState();
}

class _VideoPageDetailState extends State<VideoPageDetail> {
  bool _isIngredientButtonSelected = true;
  bool _isTutorialButtonSelected = false;

  final _myBox = Hive.box('recipesApp');

  // final List<String> mainIngredients = [
  //   '300g chân gà, luộc trong 20 phút',
  //   '2 chiếc xúc xích bò',
  //   '5 viên thịt bò',
  //   '1 quả trứng đánh tan',
  //   '50 cải xanh, cắt thành 4 miếng',
  // ];

  // final List<String> spices = [
  //   '15g tỏi',
  //   '3g mắm tôm',
  //   '25g hành tím',
  //   '50g gừng thơm',
  //   '100g ớt đỏ lớn',
  //   '50g ớt cay',
  //   '7g muối',
  //   '15g đường',
  //   '15g hành tây chiên',
  //   '25g bột gà',
  //   '50ml dầu ăn',
  // ];

  void _onButtonIngredientSelected() {
    setState(() {
      _isIngredientButtonSelected = !_isIngredientButtonSelected;
      _isTutorialButtonSelected = false;
    });
  }

  void _onButtonTutorialSelected() {
    setState(() {
      _isTutorialButtonSelected = !_isTutorialButtonSelected;
      _isIngredientButtonSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.videoModel;
    final combinedLists = [];
    final maxListLenght = min(
      video.mainIngredients.length,
      video.measures.length,
    );
    for (int i = 0; i < maxListLenght; i++) {
      combinedLists.add('${video.measures[i]} ${video.mainIngredients[i]}');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeaderImage(video: video),
              const SizedBox(height: 15),
              Container(height: 30, color: Colors.grey.withAlpha(30)),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _buildAuthorInfomationView(video: video),
              ),
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFCEA700),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    Expanded(child: _buildButtonView(isIngredientButton: true)),
                    Expanded(
                      child: _buildButtonView(isIngredientButton: false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _isIngredientButtonSelected
                  ? (Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...combinedLists.map(
                            (item) => _buildDotExpandedTextView(text: item),
                          ),
                        ],
                      ),
                    ))
                  : (Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          _buildExpandedTextView(text: video.instructions),
                        ],
                      ),
                    )),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => print('Xem Video'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Color(0x26CEA700),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.tv_rounded, color: Color(0xFFCEA700)),
                            const SizedBox(width: 10),
                            Text(
                              'Xem video',
                              style: TextStyle(
                                color: Color(0xFFCEA700),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage({required VideoModel video}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double headerHeight = screenHeight * 0.34;

    return Column(
      children: [
        SizedBox(
          height: headerHeight,
          child: Image.network(
            video.videoPath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: headerHeight * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: video.images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: index == video.images.length - 1 ? 10 : 0,
                ),
                width: headerHeight * 0.3,
                height: headerHeight * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(video.images[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 10,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                SizedBox(width: 4),
                Text(
                  'Chi tiết',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorInfomationView({required VideoModel video}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  video.videoTitle,
                  style: TextStyle(
                    color: Color(0xFF292626),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    video.updateFavoriteData();
                  });
                },
                child: Icon(
                  video.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: video.isFavorite ? Colors.red : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          video.videoTitle,
          style: TextStyle(
            color: Color(0xFF6E6767),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 4),
                Text(
                  video.rating.toString(),
                  style: TextStyle(
                    color: Color(0xFF6E6767),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(width: 2, height: 20, color: Color(0xFF6E6767)),
            const SizedBox(width: 10),
            Text(
              '${video.ratingVoteQuality.toInt()} đánh giá',
              style: TextStyle(
                color: Color(0xFF6E6767),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                image: DecorationImage(
                  image: AssetImage('images/user_avatar.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              video.authorName,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFFCEA700),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonView({required bool isIngredientButton}) {
    return MaterialButton(
      onPressed: () => isIngredientButton
          ? _onButtonIngredientSelected()
          : _onButtonTutorialSelected(),
      elevation: 0.0,
      color: _isIngredientButtonSelected && isIngredientButton
          ? Color(0xFFCEA700)
          : _isTutorialButtonSelected && !isIngredientButton
          ? Color(0xFFCEA700)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Text(
        isIngredientButton ? 'Nguyên liệu' : 'Chế biến',
        style: TextStyle(
          color: _isIngredientButtonSelected && isIngredientButton
              ? Colors.white
              : _isTutorialButtonSelected && !isIngredientButton
              ? Colors.white
              : Color(0xFFCEA700),
        ),
      ),
    );
  }

  Widget _builDescribleTitle({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotExpandedTextView({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '- ${text}.',
              style: TextStyle(
                color: Color(0xFF6E6767),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedTextView({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF6E6767),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
