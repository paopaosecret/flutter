import 'dart:convert';

import 'package:flutterstudy/bean/simple_bean.dart';
import 'package:flutterstudy/bean/test_bean.dart';

//TODO 注意
//TODO 1.Map转Json  使用jsonEncode(map)  返回Json串
//TODO 2.Json转Map  使用jsonDecode(json) 返回Map对象
//TODO 3.Json转实体  Json->Map->Bean
//TODO 4.实体转Json  bean->Map->Json

void main(){
//  testToJson();

  testFromJson();
}

void testToJson(){
  SimpleBean simpleBean = new SimpleBean();
  simpleBean.id = 2;
  simpleBean.name = "simple";
  List<SimpleBean> data = [simpleBean, simpleBean, simpleBean];
  List<String> pics = ["pic1", "pic2"];
  TestBean bean = new TestBean(
    id: 100,
    name: "test",
    simpleBean: simpleBean,
    pics: pics,
    data: data
  );

  Map map = bean.toJson();
  print(jsonEncode(map));
}

void testFromJson(){
  String json = "{\"id\":100,\"name\":\"test\",\"simpleBean\":{\"id\":2,\"name\":\"simple\"},\"pics\":[\"pic1\",\"pic2\"],\"data\":[{\"id\":2,\"name\":\"simple\"},{\"id\":2,\"name\":\"simple\"},{\"id\":2,\"name\":\"simple\"}]}";
  Map map = jsonDecode(json);

  TestBean bean = TestBean.fromJson(map);

  print(bean.toJson().toString());

}