import 'package:flutter/material.dart';
import 'package:pratical_flutter/components/button_component.dart';
import 'package:pratical_flutter/models/button_model.dart';
import 'package:pratical_flutter/models/filter_model.dart';
import 'package:pratical_flutter/utils/category_api.dart';
import 'package:pratical_flutter/utils/ingredient_api.dart';
import 'package:pratical_flutter/utils/location_api.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  FilterModel filterDatas = FilterModel();
  List<ButtonDataModel> buttonCategoryDatas = [];
  List<ButtonDataModel> buttonIngredientDatas = [];
  List<ButtonDataModel> buttonLocationDatas = [];

  String category = '';
  List<String> ingredients = [];
  String location = '';

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadFilter();
  }

  Future<void> _loadFilter() async {
    try {
      final categoryData = await CategoryApi.fetchCategoryDataApi();
      final ingredientData = await IngredientApi.fetchIngredientDataApi();
      final locationData = await LocationApi.fetchLocationDataApi();

      setState(() {
        filterDatas = FilterModel(
          categories: categoryData.categories,
          ingredients: ingredientData.ingredients,
          locations: locationData.locations,
        );
        isLoading = false;

        _fetchCategoryButtonDatas(filterDatas);
        _fetchIngredientButtonDatas(filterDatas);
        _fetchLocationButtonDatas(filterDatas);
      });
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }
  }

  void _fetchCategoryButtonDatas(filterDatas) {
    for (var categoryData in filterDatas.categories) {
      final buttonCategoryData = ButtonDataModel(
        title: categoryData,
        isPressed: false,
      );
      buttonCategoryDatas.add(buttonCategoryData);
    }
  }

  void _fetchIngredientButtonDatas(filterDatas) {
    for (var ingredientData in filterDatas.ingredients) {
      final buttonIngredientData = ButtonDataModel(
        title: ingredientData,
        isPressed: false,
      );
      buttonIngredientDatas.add(buttonIngredientData);
    }
  }

  void _fetchLocationButtonDatas(filterDatas) {
    for (var locationData in filterDatas.locations) {
      final buttonLocationData = ButtonDataModel(
        title: locationData,
        isPressed: false,
      );
      buttonLocationDatas.add(buttonLocationData);
    }
  }

  void _resetAllFilterSelectedOptions() {
    setState(() {
      for (var buttonData in buttonCategoryDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }
      for (var buttonData in buttonIngredientDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }
      for (var buttonData in buttonLocationDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }
      category = '';
      ingredients = [];
      location = '';
    });
  }

  void _onCategoryPress(index) {
    setState(() {
      if (buttonCategoryDatas[index].isPressed) {
        buttonCategoryDatas[index].isPressed = false;
        category = '';
        return;
      }

      for (var buttonData in buttonCategoryDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }
      buttonCategoryDatas[index].isPressed =
          !buttonCategoryDatas[index].isPressed;
      category = buttonCategoryDatas[index].title;
    });
  }

  void _onIngredientPress(index) {
    setState(() {
      buttonIngredientDatas[index].isPressed =
          !buttonIngredientDatas[index].isPressed;
      if (buttonIngredientDatas[index].isPressed) {
        ingredients.add(buttonIngredientDatas[index].title);
      } else {
        ingredients.remove(buttonIngredientDatas[index].title);
      }
    });
  }

  void _onLocationPress(index) {
    setState(() {
      if (buttonLocationDatas[index].isPressed) {
        buttonLocationDatas[index].isPressed = false;
        location = '';
        return;
      }

      for (var buttonData in buttonLocationDatas) {
        if (buttonData.isPressed) {
          buttonData.isPressed = false;
        }
      }

      buttonLocationDatas[index].isPressed =
          !buttonLocationDatas[index].isPressed;
      location = buttonLocationDatas[index].title;
    });
  }

  void _confirmFilter() {
    FilterResultModel? result = FilterResultModel(
      category,
      ingredients,
      location,
    );

    if (category == '' && ingredients.isEmpty && location == '') {
      result = null;
    }

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Center(child: Text('Lỗi: ${error}'));
    }

    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(500),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    // Future.microtask(() => Navigator.pop(context)),
                    icon: Icon(Icons.close),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lọc',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _resetAllFilterSelectedOptions(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      foregroundColor: Color(0xffCEA700),
                      backgroundColor: Color(0x26CEA700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Đặt lại',
                      style: TextStyle(color: Color(0xffCEA700)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 24),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildTitleView(title: 'Danh mục'),
                    const SizedBox(height: 10),
                    _buildCategoryGridView(),
                    const SizedBox(height: 10),
                    _buildTitleView(title: 'Nguyên liệu'),
                    const SizedBox(height: 10),
                    _buildIngredientGridView(),
                    const SizedBox(height: 10),
                    _buildTitleView(title: 'Khu vực'),
                    const SizedBox(height: 10),
                    _buildLocationGridView(),
                  ],
                ),
              ),
            ),
            Divider(height: 24),

            SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () => _confirmFilter(),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Color(0xFFCEA700),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleView({required String title}) {
    return Row(
      children: [
        Icon(Icons.chat_bubble_rounded, size: 24, color: Color(0xFF615358)),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF2F282A),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGridView() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.5,
        ),
        itemCount: buttonCategoryDatas.length,
        itemBuilder: (context, index) {
          final buttonData = buttonCategoryDatas[index];
          return ButtonComponent(
            buttonData: buttonData,
            onButtonToggle: () => _onCategoryPress(index),
          );
        },
      ),
    );
  }

  Widget _buildIngredientGridView() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.5,
        ),
        itemCount: buttonIngredientDatas.length,
        itemBuilder: (context, index) {
          final buttonData = buttonIngredientDatas[index];
          return ButtonComponent(
            buttonData: buttonData,
            onButtonToggle: () => _onIngredientPress(index),
          );
        },
      ),
    );
  }

  Widget _buildLocationGridView() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.5,
        ),
        itemCount: buttonLocationDatas.length,
        itemBuilder: (context, index) {
          final buttonData = buttonLocationDatas[index];
          return ButtonComponent(
            buttonData: buttonData,
            onButtonToggle: () => _onLocationPress(index),
          );
        },
      ),
    );
  }
}
