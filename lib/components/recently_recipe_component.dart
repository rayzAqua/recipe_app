import 'package:flutter/material.dart';
import 'package:pratical_flutter/models/recently_model.dart';

class RecentlyRecipeComponent extends StatelessWidget {
  final RecentlyModel recentlyModel;

  const RecentlyRecipeComponent({super.key, required this.recentlyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      width: 140,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withAlpha(30),
            blurRadius: 5.0,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(recentlyModel.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    recentlyModel.title,
                    style: TextStyle(
                      color: Color(0xFF734C10),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(recentlyModel.authorAvatarPath),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      recentlyModel.authorName,
                      style: TextStyle(
                        color: Color(0xFF002D73),
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                      ),
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
