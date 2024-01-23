import 'package:flutter/material.dart';
import 'package:flutterstudy/page/groupcallvideo/anim_switch_layout_demo_page.dart';
import 'package:flutterstudy/page/groupcallvideo/group_call_layout.dart';

import 'package:flutterstudy/widget/title_bar.dart';

class GroupCallPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _GroupCallPageState();
  }
}

class _GroupCallPageState extends State<GroupCallPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }



  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: TitleBar().titleBar(context, '群组通话'),
      body: GroupCallLayout()
    );
  }
}
