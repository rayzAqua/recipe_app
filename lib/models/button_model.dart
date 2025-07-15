class ButtonDataModel {
  String title;
  bool isPressed;

  ButtonDataModel({required this.title, required this.isPressed});

  static List<ButtonDataModel> getButtonDatas() {
    List<ButtonDataModel> buttonDatas = [];

    buttonDatas.add(ButtonDataModel(title: "Danh mục 1", isPressed: true));
    buttonDatas.add(ButtonDataModel(title: "Danh mục 2", isPressed: false));
    buttonDatas.add(ButtonDataModel(title: "Danh mục 3", isPressed: false));
    buttonDatas.add(ButtonDataModel(title: "Danh mục 4", isPressed: false));

    return buttonDatas;
  }

  static List<ButtonDataModel> getButtonDatas2() {
    List<ButtonDataModel> buttonDatas2 = [];

    buttonDatas2.add(ButtonDataModel(title: "Danh mục 1", isPressed: true));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 2", isPressed: false));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 3", isPressed: false));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 4", isPressed: false));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 1", isPressed: true));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 2", isPressed: false));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 3", isPressed: false));
    buttonDatas2.add(ButtonDataModel(title: "Danh mục 4", isPressed: false));

    return buttonDatas2;
  }
}
