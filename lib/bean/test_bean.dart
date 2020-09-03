import 'dart:convert';

import 'package:flutterstudy/bean/simple_bean.dart';

class TestBean {
  int id;
  String name;
  SimpleBean simpleBean;
  List<String> pics;
  List<SimpleBean> data;

  TestBean({
    this.id,
    this.name,
    this.simpleBean,
    this.pics,
    this.data,
  });

  factory TestBean.fromJson(Map<String, dynamic> json){
    return TestBean(
      id: json['id'] as int,
      name: json['name'] as String,
      simpleBean: json['simpleBean'] != null ? SimpleBean.fromJson(json['simpleBean']) : null,
      pics: json['pics'] != null
          ? new List<String>.from(json['pics'])
          : new List<String>(6),
      data: json['data'] != null
          ? (json['data'] as List)
          .map((i) => SimpleBean.fromJson(i))
          .toList()
          : null,

    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.simpleBean != null) {
      data['simpleBean'] = this.simpleBean.toJson();
    }
    if (this.pics != null) {
      data['pics'] = this.pics;
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}