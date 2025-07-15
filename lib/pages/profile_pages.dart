import 'package:flutter/material.dart';
import 'package:pratical_flutter/models/favorite_model.dart';
import 'package:pratical_flutter/models/video_model.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  List<FavoriteModel> favoriteDatas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDatas();
  }

  void _loadDatas() {
    setState(() {
      final videoDatas = VideoModel.getAllFavoriteVideos();
      for (var videoData in videoDatas) {
        favoriteDatas.add(FavoriteModel(imagePath: videoData.videoPath));
      }
    });
  }

  void _onFollowPress() {
    print('Follow Press Button');
  }

  void _onMessagePress() {
    print('Message Press Button');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(50),
                  color: Colors.grey.withAlpha(40),
                  image: DecorationImage(
                    image: AssetImage('images/user_avatar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Nguyễn Đình Trọng',
                style: TextStyle(
                  color: Color(0xFFA47804),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(title: 'Bài viết', number: 100),
                  ),
                  Container(width: 1, height: 40, color: Colors.grey),
                  Expanded(
                    child: _buildTextField(
                      title: 'Người theo dõi',
                      number: 100,
                    ),
                  ),
                  Container(width: 1, height: 40, color: Colors.grey),
                  Expanded(
                    child: _buildTextField(title: 'Theo dõi', number: 100),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElevatedButton(isFollowButton: true),
                  _buildElevatedButton(isFollowButton: false),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Danh sách yêu thích',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: favoriteDatas.isNotEmpty
                ? (GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: favoriteDatas.length,
                    itemBuilder: (context, index) {
                      final favoriteData = favoriteDatas[index];
                      return _buildFavoriteView(favoriteData: favoriteData);
                    },
                  ))
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String title, required int number}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF666666),
            fontSize: 11,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.06,
          ),
        ),
        Text(
          number.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildElevatedButton({required bool isFollowButton}) {
    return ElevatedButton(
      onPressed: () => isFollowButton ? _onFollowPress() : _onMessagePress(),
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(130),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: isFollowButton ? Color(0xFFCEA700) : Color(0x26CEA700),
        foregroundColor: isFollowButton ? Color(0xFFFFFFFF) : Color(0xFFCEA700),
      ),
      child: Text(
        isFollowButton ? 'Follow' : 'Message',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildFavoriteView({required FavoriteModel favoriteData}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(favoriteData.imagePath, fit: BoxFit.fill),
      ),
    );
  }
}
