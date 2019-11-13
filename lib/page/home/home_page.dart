import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';
import 'package:machinesetting_app/common/style/gsy_style.dart';
import 'package:machinesetting_app/common/utils/common_utils.dart';
import 'package:machinesetting_app/widget/gsy_tabbar_widget.dart';

class HomePage extends StatelessWidget {
  static final String sName = "home";
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }
  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(GSYICons.MAIN_DT, CommonUtils.getLocale(context).home_dynamic),
      _renderTab(GSYICons.MAIN_QS, CommonUtils.getLocale(context).home_trend),
      _renderTab(GSYICons.MAIN_MY, CommonUtils.getLocale(context).home_my),
    ];
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
    child: new GSYTabBarWidget(

    )
    );

  }
  



}