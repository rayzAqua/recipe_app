import 'package:flutter/material.dart';
import 'package:pratical_flutter/components/video_component.dart';
import 'package:pratical_flutter/models/video_model.dart';
import 'package:pratical_flutter/pages/video_page_detail.dart';

class SavePages extends StatefulWidget {
  const SavePages({super.key});

  @override
  State<SavePages> createState() => _SavePagesState();
}

class _SavePagesState extends State<SavePages> {
  List<VideoModel> videoModelDatas = [];

  bool isVideoButtonPress = true;
  bool isRecipeButtonPress = false;

  void _onDetailToggle(context, videoModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPageDetail(videoModel: videoModel),
      ),
    ).then((_) {
      setState(() {
        videoModelDatas = VideoModel.getAllFavoriteVideos();
      });
    });
  }

  void _onVideoButtonToggle() {
    setState(() {
      isVideoButtonPress = true;
      isRecipeButtonPress = false;
    });
  }

  void _onRecipeButtonToggle() {
    setState(() {
      isVideoButtonPress = false;
      isRecipeButtonPress = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFavoriteDatas();
  }

  void _loadFavoriteDatas() {
    setState(() {
      videoModelDatas = VideoModel.getAllFavoriteVideos();
    });
  }

  void _onFavoriteToggle(int index) {
    setState(() {
      videoModelDatas[index].updateFavoriteData();
      videoModelDatas = VideoModel.getAllFavoriteVideos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildButtonView(isVideoButton: true)),
              const SizedBox(width: 10),
              Expanded(child: _buildButtonView(isVideoButton: false)),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isVideoButtonPress
                ? videoModelDatas.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: videoModelDatas.length,
                          itemBuilder: (context, index) {
                            final videoData = videoModelDatas[index];
                            return GestureDetector(
                              onTap: () => _onDetailToggle(context, videoData),
                              child: VideoComponent(
                                videoModel: videoData,
                                onFavoriteToggle: () =>
                                    _onFavoriteToggle(index),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 20);
                          },
                        )
                      : Center(child: Text('Không có video yêu thích!'))
                : Center(child: Text('Không có công thức yêu thích')),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonView({required bool isVideoButton}) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () =>
            isVideoButton ? _onVideoButtonToggle() : _onRecipeButtonToggle(),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: isVideoButton && isVideoButtonPress
              ? Color(0xFFCEA700)
              : !isVideoButton && isRecipeButtonPress
              ? Color(0xFFCEA700)
              : Color(0x26CEA700),
          foregroundColor: isVideoButton && isVideoButtonPress
              ? Color(0xFFFFFFFF)
              : !isVideoButton && isRecipeButtonPress
              ? Color(0xFFFFFFFF)
              : Color(0xFFCEA700),
        ),
        child: Text(
          isVideoButton ? 'Video' : 'Công thức',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
