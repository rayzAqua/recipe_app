import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pratical_flutter/models/video_model.dart';

class VideoComponent extends StatelessWidget {
  final VideoModel videoModel;
  final VoidCallback onFavoriteToggle;

  const VideoComponent({
    super.key,
    required this.videoModel,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withAlpha(30),
            blurRadius: 8,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    videoModel.videoPath,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: 30,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFD503),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.star, size: 12, color: Colors.white),
                        Text(
                          videoModel.rating.toString(),
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(80),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      videoModel.videoLength,
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF0043B3),
                        fontWeight: FontWeight.bold,
                      ),
                      // textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        videoModel.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline_sharp,
                        size: 12,
                        color: videoModel.isFavorite
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  videoModel.videoTitle,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(20),
                        borderRadius: BorderRadiusGeometry.circular(20),
                        image: DecorationImage(
                          image: AssetImage(videoModel.authorAvatarPath),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      videoModel.authorName,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFCEA700),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
