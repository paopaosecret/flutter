

import 'package:flutter/material.dart';

///右键-》"run test in widget_test.dart"  运行此程序
void main() {
//  dynamic i = 1;       ///申明并初始化一个变量
//  printInteger(i);  ///调用一个方法
//  printStr("hello dart");
//  testNum(16, 3);
//  testStr();
//  testIsAs();
//  testObject();
//  testDynamic();
//  initSet();
  bianList();
//  testSet();
//  bianSet();
//  bianMap();

  ///同一个文件中可以访问_id，_sid这些私有属性
//  Student student = new Student(110, "张三", 18);
//  student._sid = 18000;

//  testWait();
  testFuhao();
}

void testFuhao(){
  Object obj;
  Object obj1;
  print(obj ?? obj1 ?? "obj和obj1都是空");
}

///定义一个方法
printInteger(int num){
  print("number is $num");
}

///一个表达式的方法可以简写如下
printStr(String str) => print(str);


///一、数据类型
///1.1、bool类型，对应的值 只有true 和false
///声明一个bool类型并初始化
bool flag = true;

///1.2、数字类型，包含num、int、double,其中int,double 继承自抽象类num
/// int /int 的结果 为double类型小数
/// int~/int 的结果才是 int，例如
testNum(int a, int b){
  print(a / b);
  print(a ~/ b);

  print(3.141592653.toStringAsFixed(3)); //3.142 保留3位有效小数
  print(6.6.floor());//6             向下取整
  print((-6.6).ceil()); //-6         向上取整
  print(9.9.ceil()); //10            向上取整
  print(666.6.round()); //667        四舍五入
  print((-666.6).abs()); // 666.6    取绝对值
  print(666.6.toInt()); //666        转化成int
  print(999.isEven); //false         是否是偶数
  print(999.isOdd); //true           是否是奇数
  print(666.6.toString()); //666.6   转化成字符串
}

///1.3、字符串类型：在Dart中支持单引号、双引号、三引号以及$字符串模板用法
///
testStr(){
  String _name = 'Hello Dart!';//单引号
  String title = "'Hello Dart!'";//双引号
  String description = """
          Hello Dart! Hello Dart!
          Hello Dart!
          Hello Dart! Hello Dart!
    """;//三引号
  num value = 2;
  String result = "The result is $value";//单值引用
  num width = 200;
  num height = 300;
  String square = "The square is ${width * height}";//表达式的值引用

  ///字符串类的方法
  String url = "https://mrale.ph/dartvm/";
  print(url.split("://")[0]); //字符串分割split方法，类似Java和Kotlin
  print(url.substring(3, 9)); //字符串截取substring方法, 类似Java和Kotlin
  print(url.codeUnitAt(0)); //取当前索引位置字符的UTF-16码
  print(url.startsWith("https")); //当前字符串是否以指定字符开头, 类似Java和Kotlin
  print(url.endsWith("/")); //当前字符串是否以指定字符结尾, 类似Java和Kotlin
  print(url.toUpperCase()); //大写, 类似Java和Kotlin
  print(url.toLowerCase()); //小写, 类似Java和Kotlin
  print(url.indexOf("ph")); //获取指定字符的索引位置, 类似Java和Kotlin
  print(url.contains("http")); //字符串是否包含指定字符, 类似Java和Kotlin
  print(url.trim()); //去除字符串的首尾空格, 类似Java和Kotlin
  print(url.length); //获取字符串长度
  print(url.replaceFirst("t", "A")); //替换第一次出现t字符位置的字符
  print(url.replaceAll("m", "M")); //全部替换, 类似Java和Kotlin
}

///1.4、类型检查 is 和 is!  ,强制类型转换as
testIsAs(){
  num i = 10;
  int b = i as int;
  print(b);
  print(i is int);
  print(i is! double);
}

///1.5、Object类型:Dart中 所有类都集成自Object,所以可以使用Object定义任何变量
///并且赋值之后可以更改类型
testObject(){
  Object obj = "hello";
  obj = 0xFFFFFF;
  print(obj);
}

///1.6、dynamic类型：和Object类型类似，其中var 声明的变量  没有赋值时就是dynamic类型
///它可以向Object一样赋值之后改变类型
///dynamic 一般用于接收无法确定的数据类型，例如Flutter和Native通信PlatformChannel代码
///中大量使用了dynamic类型，因为Native数据类型可能无法对应dart中的数据类型，
///此时dart接收一般会使用dynamic类型

testDynamic(){
  dynamic color = 'black';
  color = 0xFF0000;
  printInteger(color);
}

///二，变量和常量
///2.1在dart中可以使用var来替代具体类型的声明，会自动推导变量的类型，
///这是因为var并不是直接存储值，而是存储值的对象引用，所以var可以声明任何变量。
///需要注意的是: 如果var声明的变量开始不初始化，不仅值可以改变它的类型也是可以被修改的，
///但是一旦开始初始化赋值后，它的类型就确定了，后续不能被改变。
testVar(){
  var color; // 仅有声明未赋值的时候，这里的color的类型是dynamic,所以它的类型是可以变的
  color = 'red';
  print(color is String); //true
  color = 0xffff0000;
  print(color is int); //true

  var colorValue = 0xffff0000; //声明时并赋值，这里colorValue类型已经推导出为int,并且确定了类型
  //colorValue = 'red'; //错误，这里会抛出编译异常，String类型的值不能赋值给int类型
  print(colorValue is int); //true
}

///2.2、常量和变量
///在dart中声明常量可以使用const或final 两个关键字
///注意: 这两者的区别在于如果常量是编译期就能初始化的就用const
///如果常量是运行时期初始化的就用final
testConstFinal() {
  const PI = 3.141592653;         //const定义编译时常量
  final nowTime = DateTime.now(); //final定义运行时常量
}

///三、集合（List,Set,Map）
///3.1、List
///3.1.1初始化 使用[],Set使用{}
listInit(){
  List<String> list = ["zhangsna", "lisi","wangwu"];
  var strLsit = <String>["laoliu","laoqi"];
}
///3.1.2常用函数
listMethod(){
  List<String> colorList = ['red', 'yellow', 'blue', 'green'];
  colorList.add('white');           //通过add添加一个新的元素
  print(colorList[2]);              //直接使用数组下标形式访问元素
  print(colorList.length);          //获取集合的长度
  colorList.insert(1, 'black');     //在集合指定index位置插入指定的元素
  colorList.removeAt(2);            //移除集合指定的index=2的元素，第3个元素
  colorList.clear();                //清除所有元素
  print(colorList.sublist(1,3));    //截取子集合
  print(colorList.getRange(1, 3));  //获取集合中某个范围元素
  print(colorList.join('<--->'));   //用<--->隔开转为string，输出: red<--->yellow<--->blue<--->green
  print(colorList.isEmpty);         //判断list是空
  print(colorList.contains('green'));
}

///3.1.3、list遍历
bianList() {
  List<String> list = ["one", "two"];

  print(list.join(" "));

  //第一种遍历方式
  for (var i = 0; i < list.length; i++) {
    print(list[i]);
  }

  ///第二种方式
  list.forEach((item) {
    print(item);
  });

  ///第三种方式
  for (var item in list) {
    print(item);
  }

  ///第四种方式
  while (list.iterator.moveNext()) {
    print(list.iterator.current);
  }
}

///3.2 Set 不包含重复的元素,添加重复的元素时会返回false,
///3.2.1 Set初始化 使用{}
initSet(){
  Set<String> sets = {"hello", "word"};
  var sets1 = <String>{"one", "two"};
  print(sets.join("<--->"));
}

///3.2.2 集合中的交、并、补集
testSet(){
  Set<String> set1 = {"one", "two", "three"};
  Set<String> set2 = {"two", "three", "four", "five"};

  print(set1.union(set2));        //并集
  print(set1.intersection(set2)); //交集
  print(set1.difference(set2));   //补集:set1不同于set2的元素集合
}
///3.2.3遍历，和list相同
bianSet(){
  Set<String> colorSet = {'red', 'yellow', 'blue', 'green'};
//  //for-i遍历
//  for (int i = 0; i < colorSet.length; i++) {
//    print(colorSet[i]);  //可以使用var或int
//  }
  //forEach遍历
  colorSet.forEach((color) => print(color)); //forEach的参数为Function. =>使用了箭头函数
  //for-in遍历
  for (var color in colorSet) {
    print(color);
  }
  //while+iterator迭代器遍历，类似Java中的iteator
//  while (colorSet.iterator.moveNext()) {
//    print(colorSet.iterator.current);
//  }
}

///3.3 Map 、key-value形式存储，并且 Map对象的中key是不能重复的
///3.3.1初始化
initMap(){
  Map<String, int> map1 = {"zhangsan" : 10, "lisi" : 9};
  var map2 = <String, int>{"wangwu": 8, "laoliu" : 7};
}

///3.3.2 map相关方法
mapMethod(){
  Map<String, int> colorMap = {'white': 0xffffffff, 'black':0xff000000};
  print(colorMap.containsKey('green'));         //false
  print(colorMap.containsValue(0xff000000));    //true
  print(colorMap.keys.toList());                //['white','black']
  print(colorMap.values.toList());              //[0xffffffff, 0xff000000]
  colorMap['white'] = 0xfffff000;               //修改指定key的元素
  colorMap.remove('black');                     //移除指定key的元素
}

///3.3.3 map遍历
bianMap(){
  Map<String, int> colorMap = {'white': 0xffffffff, 'black':0xff000000};
  //for-each key-value
  colorMap.forEach((key, value){
    print("color: $key, value : $value");
  });
}

///3.3.4 list转换为map
listToMap(){
  var key = <String>["key1", "key2"];
  var value = <String>["1", "2"];
  Map map = Map.fromIterables(key, value);
  print(map);
}

///集合常用操作符
testSetMap(){
  List<String> colorList = ['red', 'yellow', 'blue', 'green'];
  //forEach箭头函数遍历
  colorList.forEach((color) => {print(color)});
  colorList.forEach((color) => print(color)); //箭头函数遍历，如果箭头函数内部只有一个表达式可以省略大括号

  //every函数的使用，判断里面的元素是否都满足条件，返回值为true/false
  print(colorList.every((color) => color == 'red'));

  //sort函数的使用
  List<int> numbers = [0, 3, 1, 2, 7, 12, 2, 4];
  numbers.sort((num1, num2) => num1 - num2); //升序排序
  numbers.sort((num1, num2) => num2 - num1); //降序排序
  print(numbers);

  //where函数使用，相当于Kotlin中的filter操作符，返回符合条件元素的集合
  print(numbers.where((num) => num > 6));

  //firstWhere函数的使用，相当于Kotlin中的find操作符，返回符合条件的第一个元素，如果没找到返回null
  print(numbers.firstWhere((num) => num == 5, orElse: () => -1)); //注意: 如果没有找到，执行orElse代码块，可返回一个指定的默认值

  //singleWhere函数的使用，返回符合条件的第一个元素，如果没找到返回null，但是前提是集合中只有一个符合条件的元素, 否则就会抛出异常
  print(numbers.singleWhere((num) => num == 4, orElse: () => -1)); //注意: 如果没有找到，执行orElse代码块，可返回一个指定的默认值

  //take(n)、skip(n)函数的使用，take(n)表示取当前集合前n个元素, skip(n)表示跳过前n个元素，然后取剩余所有的元素
  print(numbers.take(5).skip(2));

  //List.from函数的使用，从给定集合中创建一个新的集合,相当于clone一个集合
  print(List.from(numbers));

  //expand函数的使用, 将集合一个元素扩展成多个元素或者将多个元素组成二维数组展开成平铺一个一位数组
  var pair = [
    [1, 2],
    [3, 4]
  ];
  print('flatten list: ${pair.expand((pair) => pair)}');

  var inputs = [1, 2, 3];
  print('duplicated list: ${inputs.expand((number) =>[
    number,
    number,
    number
  ])}');
}

///四：流程控制
///for  if  else   while  do  while  continue break switch case 三目运算符（? :）
///

///五：运算符
///5.1算术运算符  + - * /  ~/(整除)   %（取余）
///5.2条件运算符  > < == !=   >= <=
///5.3逻辑运算符  && || ！
///5.4位运算符 位与&  位或\| 位非~ 异或^ 左移<< 右移>>
///5.5空安全运算符
///  1、result = expr1 ?? expr2   如果发现expr1为null,就返回expr2的值，否则就返回expr1的值
///  2、expr1 ??= expr2           等价于 expr1 = expr1 ?? expr2
///  3、result = expr1?.value     如果expr1不为null就返回expr1.value，否则就会返回null
///
/// 5.6级联运算符  级联操作符是 ..  可以让你对一个对象中字段进行链式调用操作
///question
//    ..id = '10001'
//    ..stem = '第一题: xxxxxx'
//    ..choices = <String> ['A','B','C','D']
//    ..hint = '听音频做题';
/// 5.7运算符重载

///六，异常，使用的也是try-catch-finally; 对特定异常的捕获使用on关键字.
///dart中的常见异常有: NoSuchMethodError(当在一个对象上调用一个该对象没有 实现的函数会抛出该错误)
///ArgumentError (调用函数的参数不合法会抛出这个错误)
///

testTryCatch(){
  int num = 18;
  int result = 0;
  try {
    result = num ~/ 0;
  } catch (e) {//捕获到IntegerDivisionByZeroException
    print(e.toString());
  } finally {
    print('$result');
  }

  try {
    result = num ~/ 0;
  } on IntegerDivisionByZeroException catch (e) {//捕获特定异常
    print(e.toString());
  } finally {
    print('$result');
  }
}

///七  函数
///在dart中函数的地位一点都不亚于对象，支持闭包和高阶函数，而且dart中的函数也会比Java要灵活的多
///比如支持默认值参数、可选参数、命名参数等.
///7.1函数基本用法
num sum(num a, num b) {
  return a + b;
}

///7.2函数传参
void m1(int a, int b, int c){}// 参数个数  和顺序完全一样
void m2([int a, int b, int c]){}//参数顺序一样， 个数可以不一样
void m3({int a, int b, int c}){} //参数顺序和个数都可以变化
void m4(int a, intb, {int c, int d}){}//a,b 个数顺序完全一样 ， 后两个顺序和个数可以变化
void m5({num a = 100}){}      //其中{} 为可选参数，可选参数可以设置默认值
void m6(){
  m1(1, 2, 3);// 参数个数  和顺序完全一样
  m2(2,3);    //参数顺序一样， 个数可以不一样
  m3(c:2,b:3);  //参数顺序和个数都可以变化
  m4(1,2,d:4);  //a,b 个数顺序完全一样 ， 后两个顺序和个数可以变化
}

///7.3函数类型和高阶函数
///在dart函数也是一种类型Function,可以作为函数参数传递，也可以作为返回值。

///Function 作为参数
void add(int a, int b, [Function op1, Function op2]){}
void testFunction(){

  ///定义一个函数，
  Function op = (a){
    return a * a;
  };

  ///函数作为参数
  add(1, 2, op(3));
}

///7.4、函数的简化以及箭头函数
///在dart中的如果在函数体内只有一个表达式，那么就可以使用箭头函数来简化代码
void printNum() => print("hello dart");
void printDart(String str) => print(str);


///八、面向对象
///在dart中一切皆是对象，所以面向对象在Dart中依然举足轻重
///8.1 类的基本定义和使用
class Person{
  int _id;   //_开头的属性为私有属性，外部文件无法访问
  String name;
  int age;

  int sex;

  //TODO 定义一个构造器，用来生成一个类的实例, 其中sex = 1 是初始化列表
  Person(this._id, this.name, this.age) : sex = 1;

  //TODO 注意，这里写法可能大家没见过， 这点和Java是不一样，这里实际上是一个dart的语法糖。
//TODO 与上述的等价代码,当然这也是Java中必须要写的代码
//  Person(String name, int age){
//    this.name = name;
//    this.age = age;
//  }

  //TODO 定义一个命名构造函数 方式1，继承自主构造器
  Person.name(String name) : this(0, name, 1);
  SingleChildScrollView scrollView;
  //TODO 定义一个命名构造函数 方式2，初始化列表方式
  Person.age(this.age) : _id = 0, name = "";
}

class Student extends Person{
  int _sid;
  Student(int id, String name, int age) : _sid = 1, super(id, name, age);

//  @override
//  void set _id(int __id) {
//    // TODO: implement _id
//    super._id = __id;
//  }
//
//  @override
//  // TODO: implement _id
//  int get _id => super._id;
}

testDelay() {
  Future.delayed(new Duration(seconds: 3), () {
    return "hello Future";
  }).then((data) {
    ///延迟3s执行此操作
    print(data);
  }).catchError((e) {
    ///当异常在此执行
    print(e);
  }).whenComplete(() {
    ///无论有没有异常，上述方法走完都会走这里
    print("Future conplete");
  });
}

testWait(){
  Future.wait([
    Future.delayed(new Duration(seconds: 1), () {   //执行网络请求1
      printStr("请求1");
      return "hello Future";
    }),
    Future.delayed(new Duration(seconds: 2), () {   //执行网络请求2
      printStr("请求2");
      return "hello Network";
    })
  ]).then((data) {   //两个网络请求执行成功之后执行
    ///延迟3s执行此操作
    print(data[0]);
    print(data[1]);
  }).catchError((e) {
    ///当异常在此执行
    print(e);
  }).whenComplete(() {
    ///无论有没有异常，上述方法走完都会走这里
    print("Future conplete");
  });
}

testAsync(){
  ///async用来表示函数是异步的，定义的函数会返回一个Future对象，
  ///可以使用then方法添加回调函数。
  ///await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；a
  ///wait必须出现在 async 函数内部。
  task() async {
    try{
      String id = await Future.delayed(new Duration(seconds: 2),(){
        return "请求id";
      });
      String userInfo = await Future.delayed(new Duration(seconds: 2),(){
        return "请求用户信息";
      });
      await Future.delayed(new Duration(seconds: 2),(){
        return "保存用户信息";
      });
      //执行接下来的操作
    } catch(e){
      //错误处理
      print(e);
    }
  }
}
