import 'package:flutter/material.dart';
import 'package:ganhuo/common/GlobalConfig.dart';
import 'myInfoCard.dart';
import 'myServiceCard.dart';
import 'settingCard.dart';
import 'videoCard.dart';
import 'ideaCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:ganhuo/api/Api.dart';
import 'package:ganhuo/api/http.dart';
import 'dart:convert';
import 'package:ganhuo/model/DailyResponse.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var curPage = 1;
  var listDataImage; //图片
  var listDataVideo; //视频

  @override
  void initState() {
    super.initState();
    getNewsList("福利");
    getNewsList("休息视频");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('我的'),
        ),
        body: new SingleChildScrollView(
        child: new Container(
        color: GlobalConfig.backgroundColor,
        child: new Column(
          children: <Widget>[
            myInfoCard(context),
            myServiceCard(context),
            settingCard(context),
            videoCard(context, listDataImage), //图片卡片
            ideaCard(context, listDataVideo)
          ],
        ),
      ),
    ));
  }

  //网络请求
  getNewsList(String type) {
    var url = Api.FEED_URL + type + '/4/' + this.curPage.toString();
    print("feedListUrl: $url");
    HttpExt.get(url, (data) {
      if (data != null) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(jsonDecode(data));
        if (!categoryResponse.error) {
          var _listData = categoryResponse.results;
          if (_listData.length > 0) {
            setState(() {
              if (type == "福利") {
                listDataImage = _listData;
              } else {
                listDataVideo = _listData;
              }
            });
          }
        }
      }
    }, (e) {
      print("get news list error: $e");
    });
  }
}
