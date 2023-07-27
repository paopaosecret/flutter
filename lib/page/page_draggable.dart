import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/bean/service_item_bean.dart';
import 'package:flutterstudy/utils/ui_utils.dart';

///用于展示Demo的界面，其中的MaterialApp、ThemeData、AppBar都是不必要的，只是稍微美观一点。
class DraggablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ItemBean> dataList = <ItemBean>[];
    for(int i = 0; i<  5; i++){
      ItemBean itemBean = new ItemBean(id: i, name: "name${i}");
      dataList.add(itemBean);
    }
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("DraggableDemo"),
          ),
          body: GridViewPage3(dataList)),
//          body: Text("")),
    );
  }
}
//List<ItemBean> list = new List();

class GridViewPage3 extends StatefulWidget {
  late List<ItemBean> dataList;
  GridViewPage3(List<ItemBean> dataList){
    this.dataList = dataList;
  }

  @override
  State<StatefulWidget> createState() => _GridViewPage3State();
}

class _GridViewPage3State extends State<GridViewPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: UITools.getScreenWidth(context),
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Text("编辑"),
          ),
          Positioned(
            top: 30,
            child: Container(
              width: UITools.getScreenWidth(context),
              height: 270,
              margin: EdgeInsets.all(0),
              child: GridView.count(
                padding: EdgeInsets.zero,
                childAspectRatio: 1.5, //item宽高比
                scrollDirection: Axis.vertical, //默认vertical
                crossAxisCount: 4, //列数
                children: _buildGridChildren(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //生成widget列表
  List<Widget> _buildGridChildren(BuildContext context) {
    final List<Widget> list = <Widget>[];
    for (int x = 0; x < widget.dataList.length; x++) {
      list.add(_buildItemWidget(context, x));
    }
    return list;
  }

  Widget _buildItemWidget(BuildContext context, int index) {
    return LongPressDraggable(
      data: index,
      //这里data使用list的索引，方便交换数据
      child: DragTarget<int>(
        //松手时 如果onWillAccept返回true 那么久会调用
        onAccept: (data) {
          setState(() {
            final temp = widget.dataList[data];
            widget.dataList.remove(temp);
            widget.dataList.insert(index, temp);
          });
        },
        //绘制widget
        builder: (context, data, rejects) {
          return Container(
            margin: EdgeInsets.all(5),
            color: Color(0xFF00FF00),
            child: Center(
              child: Text('x = ${widget.dataList[index].id}'),
            ),
          );
        },
        //手指拖着一个widget从另一个widget头上滑走时会调用
        onLeave: (data) {
          print('$data is Leaving item $index');
        },
        //接下来松手 是否需要将数据给这个widget？  因为需要在拖动时改变UI，所以在这里直接修改数据源
        onWillAccept: (data) {
          print('$index will accept item $data');
          return true;
        },
      ),
      onDragStarted: () {
        //开始拖动，备份数据源
        print('item $index ---------------------------onDragStarted');
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        print(
            'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
        //拖动取消，还原数据源
      },
      onDragCompleted: () {
        //拖动完成，刷新状态，重置willAcceptIndex
        print("item $index ---------------------------onDragCompleted");
      },
      //用户拖动item时，那个给用户看起来被拖动的widget，（就是会跟着用户走的那个widget）
      feedback: SizedBox(
        child: Center(
          child: Icon(Icons.feedback),
        ),
      ),
      //这个是当item被拖动时，item原来位置用来占位的widget，（用户把item拖走后原来的地方该显示啥？就是这个）
      childWhenDragging: Container(
        child: Center(
          child: Icon(Icons.child_care),
        ),
      ),
    );
  }
}
