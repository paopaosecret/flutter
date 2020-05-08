import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/widget/toast.dart';
import 'marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///首页-我的页面
class FragmentMe extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<FragmentMe> {
  List<MeItemBean> dataList = new List();
  bool testRefresh = true;

  ///初始化状态数据
  @override
  void initState() {
    for(ItemType type in ItemType.values){
      MeItemBean itemBean = new MeItemBean();
      itemBean.type = type;
      dataList.add(itemBean);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    print("screenWidth: ${ScreenUtil.screenWidth}");
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: new RefreshIndicator(
          backgroundColor: Colors.amber, //设置下拉刷新的精度条的背景颜色
          onRefresh: _doRefresh, //设置下拉刷新处理事件
          displacement: 40.0, //设置下拉刷新的精度条的到listView顶部的距离
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              MeItemBean bean = dataList[index];
              switch(bean.type){
                case ItemType.TYPE_TITLE_VIP:
                  return _buildTitleVip(bean);
                case ItemType.TYPE_TITLE_NVIP:
                  return _buildTitleNVip(bean);
                case ItemType.TYPE_RANKING:
                  return _buildRanking(bean);
                case ItemType.TYPE_ORDER:
                  return _buildOrder(bean);
                case ItemType.TYPE_SHOP:
                  return _buildShop(bean);
                case ItemType.TYPE_WELFARE:
                  return _buildWelfare(bean);
                case ItemType.TYPE_HELP:
                  return _buildHelp(bean);
              }
              return Text("llala");
            },
          ),
      ),
    );
  }

  ///构建vip 头部
  Widget _buildTitleVip(MeItemBean bean) {
    return Container(
      height: 131.5,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          SizedBox.expand(
            child: Image.asset("images/icon_bg_credit_vip.png",
              fit: BoxFit.cover,),
          ),
          Positioned(
            left: 15,
            top: 47.5,
            child: Image.asset("images/iv_boy_user.png",width:50,height:50),
          ),
          Positioned(
            left: 75,
            top: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("zhanghu12", style: new TextStyle(
                  fontSize: 20,
                  color: Color(0xFF333333),
                ),),
                Padding(
                  padding: const EdgeInsets.only(top:3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){
                          ToastUtils.showToast("跳转会员页面");
                        },
                        child: Container(
                          height: 16,
                          child: Chip(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.fromLTRB(3, -15, 3, 0),
                            backgroundColor: Colors.redAccent,
                            label: Text("会员1年", style: new TextStyle(
                              fontSize: 10,
                              color:  Color(0xFFFFFFFF),),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          ToastUtils.showToast("跳转商家分层页面");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Container(
                            height: 16,
                            child: Chip(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.fromLTRB(3, -15, 3, 0),
                              backgroundColor: Colors.redAccent,
                              label: Text("532分", style: new TextStyle(
                                fontSize: 10,
                                color:  Color(0xFFFFFFFF),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),

          Positioned(
            top: 36,
            right: 15,
            child: GestureDetector(
              child: Image.asset("images/icon_credit_setting.png", width:22, height:22),
              onTap: (){
                ToastUtils.showToast("跳转设置页面");

              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 10,
              width: 360,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:Radius.circular(10),
                  topRight:Radius.circular(10)),
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///构建非vip 头部
  Widget _buildTitleNVip(MeItemBean bean) {
    return Container(
      width: double.infinity,
      height: 131.5,

      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          SizedBox.expand(
            child: Image.asset("images/icon_bg_credit_novip.png",
              fit: BoxFit.cover,),
          ),
          Positioned(
            left: 15,
            top: 47.5,
            child: Image.asset("images/iv_boy_user.png",width:50,height:50),
          ),

          Positioned(
            left: 75,
            top: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("zhanghu12", style: new TextStyle(
                  fontSize: 20,
                  color: Color(0xFF333333),
                ),),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: GestureDetector(
                    onTap: (){
                      ToastUtils.showToast("跳转设置页面");
                    },
                    child: Container(
                      height: 16,
                      child: new Chip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.fromLTRB(3, -15, 3, 0),
                        backgroundColor: Colors.redAccent,
                        label: Text("开通会员，赢得更多商机", style: new TextStyle(
                          fontSize: 10,
                          color:  Color(0xFFFFFFFF),),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 36,
            right: 15,
            child: GestureDetector(
              child: Image.asset("images/icon_credit_setting.png", width:22, height:22),
              onTap: (){
                ToastUtils.showToast("跳转设置页面");
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 360,
              height: 10,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(10),
                    topRight:Radius.circular(10)),
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///构建排行榜模块
  Widget _buildRanking(MeItemBean bean) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.only(left:10, right:10, top:10, bottom:15.0),
        child: GestureDetector(
          onTap: (){   //排行榜模块被店家
            ToastUtils.showToast("跳转设置页面");
          },
          child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 68,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("images/icon_bg_ranking.png"),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 35,
                  child: Container(
                    width: 200,
                    height: 20,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Marquee(3, _rankItemBuilder),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }


  Widget _rankItemBuilder(BuildContext context, int index){
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: Image.network("https://accounts.processon.com/uphoto/1/98/58aa4919e4b07158582714ea.png"
              ,width: 16,height: 16,),
          ),

          SizedBox(height: 16.0), // 图片下面预留的高度
          Text(
              "index${index}titletitlet",
              style:TextStyle(
                fontSize: 12,
                color: Color(0xFFFF552E),
              )
          ),
        ],
      ),
    );
  }


  ///构建我的订单模块
  Widget _buildOrder(MeItemBean bean) {
    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:15, top:10.0),
            child: Text("我的订单",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0 , right: 10.0,bottom: 15, top: 5),
            child: Container(
              width: double.infinity,
              height: 70,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,   //设置item数量
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, //横轴三个子widget
                    childAspectRatio: 1.0 //宽高比为1时，子widget
                ),
                itemBuilder: _itemOrder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemOrder(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        ToastUtils.showToast("跳转设置页面");
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network("https://dl.58cdn.com.cn/shangjiatong/sjt/homemoudle/order/sjxy.png", height: 36, width: 36,),
            Text("index$index"),
          ],
        ),
      ),
    );
  }

  ///构建我的店铺模块
  Widget _buildShop(MeItemBean bean) {
    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:15, top:10.0),
            child: Text("我的店铺",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10.0, left: 10, right: 10),
            child: Container(
              width: double.infinity,
              height: 70,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,   //设置item数量
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, //横轴三个子widget
                    childAspectRatio: 1.0 //宽高比为1时，子widget
                ),
                itemBuilder: _itemShop,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemShop(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        ToastUtils.showToast("跳转设置页面");
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network("https://dl.58cdn.com.cn/shangjiatong/sjt/homemoudle/workbench/wodeshitidian_nor.png", height: 35, width: 35,),
            Text("index$index"),
          ],
        ),
      ),
    );
  }

  ///构建福利商城模块
  Widget _buildWelfare(MeItemBean bean) {
    return Container(
      width: double.infinity,
      height: 210,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 32,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 15,
                  top:10,
                  child: Text("福利商城", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                Positioned(
                  right: 15,
                  top:15,
                  child: GestureDetector(
                    onTap: (){
                      ToastUtils.showToast("跳转设置页面");
                    },
                    child: Text("更多", style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                    ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 170,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: GridView.builder(
              itemCount: 3,   //设置item数量
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //横轴三个子widget
                crossAxisSpacing: 5, //间隔
                childAspectRatio: 0.55,
              ),
              itemBuilder: _itemWelfare,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWelfare(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        ToastUtils.showToast("跳转福利商城${index}页面");
      },
      child: Wrap(
            alignment: WrapAlignment.start,     ///主轴方向的对齐方式
            runAlignment: WrapAlignment.start,  ///纵轴方向的对齐方式
            verticalDirection:VerticalDirection.down,
            spacing: 0, // 主轴(水平)方向间距
            runSpacing: 2.0, // 纵轴（垂直）方向间距
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15.0), //容器外补白
                height: 105,
                width: 105,
                alignment: Alignment.center,
                child: Image.network("https://pic4.58cdn.com.cn/m1/bigimage/n_v25685f0bc75a64758bf22e13f24b53256.jpg", height: 105, width: 105,)
              ),
              Container(
                alignment:Alignment.topCenter,  //设置对齐方式
                child: Text("防水补漏水补漏$index", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),)
              ),
              Container(
                  alignment:Alignment.topLeft,  //设置对齐方式
                  child: Text("${index} 通过", style: TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),)
              ),
              Container(
                  alignment:Alignment.topLeft,  //设置对齐方式
                  child: Text("￥199.${index}", style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration:TextDecoration.lineThrough,
                  ),)
              ),
            ],
          ),
    );
  }

  ///构建帮助中心模块
  Widget _buildHelp(MeItemBean bean) {
    return  GestureDetector(
      onTap: (){
        ToastUtils.showToast("跳转帮助页面");
      },
      child: Padding(
        padding: const EdgeInsets.only(top:10, bottom: 10),
        child: Container(
          width: double.infinity,
          height: 50,
          color: Color(0xFFFFFFFF),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 15,
                top:10,
                child: Text("帮助中心", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                ),),
              ),
              Positioned(
                right: 15,
                top:15,
                child: Text("投诉/认证/申诉/答疑/联系客服", style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _doRefresh() async {
    testRefresh = !testRefresh;
    await Future<void>.delayed(Duration(seconds: 1), () {
      print("刷新开始");
      setState(() {
        dataList.clear();
        for(ItemType type in ItemType.values){
          if(testRefresh){
            if(type == ItemType.TYPE_TITLE_NVIP){
              continue;
            }
          }else{
            if(type == ItemType.TYPE_TITLE_VIP){
              continue;
            }
          }
          MeItemBean itemBean = new MeItemBean();
          itemBean.type = type;
          dataList.add(itemBean);
        }
      });

    });
  }

}

class MeItemBean {
  ItemType type; //		北京朝阳酒仙桥
  Map data; //	13510577981
}

///刷新过程状态
enum ItemType{
  TYPE_TITLE_VIP,        ///vip头部模块
  TYPE_TITLE_NVIP,       ///非vip头部模块
  TYPE_RANKING,          ///排行榜模块
  TYPE_ORDER,            ///我的订单模块
  TYPE_SHOP,             ///我的店铺模块
  TYPE_WELFARE,          ///福利商城模块
  TYPE_HELP,             ///帮助中心模块
}