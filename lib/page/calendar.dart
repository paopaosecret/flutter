import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() {
    // TODO: implement createState
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  DateTime dateTime = DateTime.now();
  int year = 1970;
  int month = 1;
  int day = 1;
  int fristWeek = 1;
  int maxDay = 30;

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
    fristWeek = getMonthInitWeek(year, month);
    maxDay = getDaysByYearAndMonth(year, month);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              width: UITools.getScreenWidth(context),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Center(child: Text("<<")),
                        onTap: () {
                          setState(() {
                            year--;
                            fristWeek = getMonthInitWeek(year, month);
                            maxDay = getDaysByYearAndMonth(year, month);
                          });
                        },
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Center(child: Text("<")),
                        onTap: () {
                          setState(() {
                            month--;
                            if(month <= 0){
                              year--;
                              month = 12;
                            }
                            fristWeek = getMonthInitWeek(year, month);
                            maxDay = getDaysByYearAndMonth(year, month);
                          });
                        },
                      )),
                  Center(child: Text("${year}年${month}月")),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Center(child: Text(">")),
                        onTap: () {
                          setState(() {
                            month++;
                            if(month >12){
                              year++;
                              month = 1;
                            }
                            fristWeek = getMonthInitWeek(year, month);
                            maxDay = getDaysByYearAndMonth(year, month);
                          });
                        },
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Center(child: Text(">>")),
                        onTap: () {
                          setState(() {
                            year++;
                            fristWeek = getMonthInitWeek(year, month);
                            maxDay = getDaysByYearAndMonth(year, month);
                          });
                        },
                      )),
                ],
              ),
            ),
            Container(
              width: UITools.getScreenWidth(context),
              height: 40,
              child: GridView.count(
                padding: EdgeInsets.zero,
                childAspectRatio: 1.5,
                //item宽高比
                scrollDirection: Axis.vertical,
                //默认vertical
                crossAxisCount: 7,
                //列数
                children: _buildGridChildren(context),
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                padding: EdgeInsets.zero,
                childAspectRatio: 1.5,
                //item宽高比
                scrollDirection: Axis.vertical,
                //默认vertical
                crossAxisCount: 7,
                //列数
                children: _buildDays(context),
              ),
            )
            // GridView(),
          ]),
    );
  }

  List<Widget> _buildGridChildren(BuildContext context) {
    final List list = List<Widget>();
    for (int x = 1; x <= 7; x++) {
      list.add(Center(
          child: Text(
        "周${x}",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFFFF0000),
        ),
      )));
    }
    return list;
  }

  //获取月份下第一天是周几
  int getMonthInitWeek(int year, int month) {
    var d = new DateTime(year, month, 1);
    print(d.weekday);
    return d.weekday;
  }

  /**
   * 获取当月最大天数
   */
  int getDaysByYearAndMonth(int year, int month) {
    int result;
    if (2 == month) {
      if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
        result = 29;
      } else {
        result = 28;
      }
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      result = 30;
    } else {
      result = 31;
    }
    return result;
  }

  List<Widget> _buildDays(BuildContext context) {
    List<Widget> list = List<Widget>();
    for (int i = 1; i < maxDay + fristWeek; i++) {
      if (i < fristWeek) {
        list.add(Center(child: Text(" ")));
      } else {
        list.add(Center(child: Text("${i - fristWeek + 1}")));
      }
    }
    return list;
  }
}
