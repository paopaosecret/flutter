class SimpleBean {
  int id;
  String name;

  SimpleBean({
    this.id,
    this.name,
  });

  factory SimpleBean.fromJson(Map<String, dynamic> json){
    return SimpleBean(
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