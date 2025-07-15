import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pratical_flutter/components/button_component.dart';
import 'package:pratical_flutter/components/recently_recipe_component.dart';
import 'package:pratical_flutter/components/recipe_component.dart';
import 'package:pratical_flutter/components/search_bar_component.dart';
import 'package:pratical_flutter/components/video_component.dart';
import 'package:pratical_flutter/models/button_model.dart';
import 'package:pratical_flutter/models/recently_model.dart';
import 'package:pratical_flutter/models/recipe_model.dart';
import 'package:pratical_flutter/models/video_model.dart';
import 'package:pratical_flutter/pages/video_page_detail.dart';
import 'package:pratical_flutter/utils/ingredient_api.dart';
import 'package:pratical_flutter/utils/video_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('recipesApp');

  List<ButtonDataModel> buttonDatas = [];
  List<RecipeModel> recipeDatas = [];
  List<RecentlyModel> recentlyDatas = [];
  List<ButtonDataModel> buttonDatas2 = [];

  List<VideoModel>? videoDatas;
  bool isLoadingFood = true;
  bool isLoadingIngredient = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadDatas();
    _loadFood();
    _loadIngredient();
  }

  void _loadDatas() {
    setState(() {
      buttonDatas = ButtonDataModel.getButtonDatas();
      recipeDatas = RecipeModel.getRecipeDatas();
      recentlyDatas = RecentlyModel.getRecentlyDatas();
    });
  }

  Future<void> _loadFood() async {
    try {
      final futures = List.generate(
        5,
        (_) => VideoApi.fetchRandomVideoDataApi(),
      );

      final results = await Future.wait(futures);
      setState(() {
        videoDatas = results;
        isLoadingFood = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoadingFood = false;
      });
    }
  }

  Future<void> _loadIngredient() async {
    try {
      final results = await IngredientApi.fetchIngredientDataApi();
      setState(() {
        for (var result in results.ingredients) {
          buttonDatas2.add(ButtonDataModel(title: result, isPressed: false));
        }
        isLoadingIngredient = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoadingIngredient = false;
      });
    }
  }

  void _onDetailToggle(context, videoModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPageDetail(videoModel: videoModel),
      ),
    ).then((_) {
      setState(() {
        videoModel.getFavoriteData();
      });
    });
  }

  void _onFavoriteToggle(int index) {
    setState(() {
      videoDatas![index].updateFavoriteData();
    });
  }

  void _onPressToggle(int index) {
    setState(() {
      for (var buttonData in buttonDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }
      buttonDatas[index].isPressed = !buttonDatas[index].isPressed;
    });
  }

  void _onIngredientPressToggle(int index) {
    setState(() {
      buttonDatas2[index].isPressed = !buttonDatas2[index].isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingFood || isLoadingIngredient) {
      return Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text('Lỗi: ${error}'));
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5),
            child: SearchBarComponent(),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      _buildTitle(title: 'TP. Hồ Chí Minh'),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: videoDatas!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 20),
                          itemBuilder: (BuildContext context, int index) {
                            final videoData = videoDatas![index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 1.0,
                                right: 1.0,
                                bottom: 1.0,
                              ),
                              child: GestureDetector(
                                onTap: () =>
                                    _onDetailToggle(context, videoData),
                                child: VideoComponent(
                                  videoModel: videoData,
                                  onFavoriteToggle: () =>
                                      _onFavoriteToggle(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      _buildTitle(title: 'Danh mục'),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: buttonDatas.length,
                          itemBuilder: (BuildContext context, int index) {
                            final buttonData = buttonDatas[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: ButtonComponent(
                                buttonData: buttonData,
                                onButtonToggle: () => _onPressToggle(index),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: recipeDatas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RecipeComponent(
                              recipeModel: recipeDatas[index],
                              onSaveToggle: () => {},
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Công thức gần đây',
                          style: TextStyle(
                            color: Color(0xFF181B18),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 190,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: recentlyDatas.length,
                          itemBuilder: (BuildContext context, int index) {
                            final recentlyData = recentlyDatas[index];
                            return RecentlyRecipeComponent(
                              recentlyModel: recentlyData,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nguyên liệu',
                          style: TextStyle(
                            color: Color(0xFF181B18),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                                childAspectRatio: 2.5,
                              ),
                          itemCount: buttonDatas2.length,
                          itemBuilder: (context, index) {
                            final buttonData = buttonDatas2[index];
                            return ButtonComponent(
                              buttonData: buttonData,
                              onButtonToggle: () =>
                                  _onIngredientPressToggle(index),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 15,
          ),
        ),
        Text(
          'Xem tất cả',
          style: TextStyle(color: Color(0xFFCEA700), fontSize: 15),
        ),
      ],
    );
  }
}
