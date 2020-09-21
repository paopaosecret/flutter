class FavoritiesState {
  List<FavoritiesItem> dataList = new List();
  bool loadMoreFlag = false;
  bool allSelect = false;
  bool isEdit = false;
  int selectCount = 0;

  FavoritiesState({
    this.dataList,
    this.loadMoreFlag,
    this.allSelect,
    this.isEdit,
    this.selectCount,
  });

  factory FavoritiesState.fromJson(Map<String, dynamic> json) {
    return FavoritiesState(
      dataList: json['dataList'] != null
          ? (json['dataList'] as List)
              .map((i) => FavoritiesItem.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    if (this.dataList != null) {
      data['dataList'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  FavoritiesState.initState({
    this.dataList,
    this.loadMoreFlag = false,
    this.allSelect = false,
    this.isEdit = false,
    this.selectCount = 0,
  });

  static FavoritiesState copy(FavoritiesState state) {
    return FavoritiesState(
      dataList: state.dataList,
      loadMoreFlag: state.loadMoreFlag,
      allSelect: state.allSelect,
      isEdit: state.isEdit,
      selectCount: state.selectCount,
    );
  }
}

class LabelItem {
  ///具体文本
  String text;

  ///文字颜色
  int textColor;

  ///标签背景色
  int bgColor;

  LabelItem({
    this.text,
    this.textColor,
    this.bgColor,
  });

  factory LabelItem.fromJson(Map<String, dynamic> json) {
    return LabelItem(
      text: json['text'] as String,
      textColor: json['textColor'] as int,
      bgColor: json['bgColor'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data['text'] = this.text;
    data['textColor'] = this.textColor;
    data['bgColor'] = this.bgColor;
    return data;
  }
}

class FavoritiesItem {
  int id;
  String name;

  ///用户名
  String phone;

  ///电话号码
  String state;

  ///状态
  String source;

  ///来源
  String city;

  ///城市
  String cate;

  ///类目
  String time;

  ///时间
  bool isSelect;

  ///编辑是否选中
  List<LabelItem> labelList;

  ///标签列表

  FavoritiesItem({
    this.id,
    this.name,
    this.phone,
    this.state,
    this.source,
    this.city,
    this.cate,
    this.time,
    this.isSelect,
    this.labelList,
  });

  factory FavoritiesItem.fromJson(Map<String, dynamic> json) {
    return FavoritiesItem(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      source: json['source'] as String,
      city: json['city'] as String,
      cate: json['cate'] as String,
      time: json['time'] as String,
      isSelect: json['isSelect'] as bool,
      labelList: json['labelList'] != null
          ? (json['labelList'] as List)
              .map((i) => LabelItem.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['state'] = this.state;
    data['source'] = this.source;
    data['city'] = this.city;
    data['cate'] = this.cate;
    data['time'] = this.time;
    data['isSelect'] = this.isSelect;
    if (this.labelList != null) {
      data['labelList'] = this.labelList.map((a) => a.toJson()).toList();
    }
    return data;
  }
}
