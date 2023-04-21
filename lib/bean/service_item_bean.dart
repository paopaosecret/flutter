class ItemBean {
  int id;
  String name;

  ItemBean({
    required this.id,
    required this.name,
  });

  factory ItemBean.fromJson(Map<String, dynamic> json){
    return ItemBean(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}