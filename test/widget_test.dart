import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'dart_test.dart';

void main(){
  testPrivate();
}

testPrivate(){
  ///不同文件不能访问Student _id  和 _sid属性
  Student student = new Student(110, "小王", 18)
    ..age=1;
  print("${student.name}是${student.age}岁了");
}
