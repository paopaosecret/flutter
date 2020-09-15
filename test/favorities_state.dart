class FavoritiesState{
  List<FavoritiesItem> dataList  = new List();

  FavoritiesState({
    this.dataList,
  });

  factory FavoritiesState.fromJson(Map<String, dynamic> json){
    return FavoritiesState(
      dataList: json['dataList'] != null
          ? (json['dataList'] as List)
          .map((i) => FavoritiesItem.fromJson(i))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    if (this.dataList != null) {
      data['dataList'] = this.dataList.map((v) => v.toJson()).toList();
    }
    return data;
  }


  FavoritiesState.initState({
    this.dataList,
  });

  static FavoritiesState copy(FavoritiesState state){
    return FavoritiesState(
      dataList: state.dataList,
    );
  }

}

class FavoritiesItem{
  int id;
  String name;           ///用户名
  String phone;          ///电话号码
  String state;         ///状态
  String source;        ///来源
  String city;          ///城市
  String cate;          ///类目
  String time;          ///时间

  FavoritiesItem({
    this.id,
    this.name,
    this.phone,
    this.state,
    this.source,
    this.city,
    this.cate,
    this.time,
  });

  factory FavoritiesItem.fromJson(Map<String, dynamic> json){
    return FavoritiesItem(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      state: json['state'] as String,
      source: json['source'] as String,
      city: json['city'] as String,
      cate: json['cate'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['state'] = this.state;
    data['source'] = this.source;
    data['city'] = this.city;
    data['cate'] = this.cate;
    data['time'] = this.time;
    return data;
  }
}