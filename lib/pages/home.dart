import 'package:flutter/material.dart';
import 'dart:async';
import '../widget/myswiper.dart';
import '../network/NetWorkUtil.dart';
import '../model/PostData.dart';
import '../api/Api.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
class Home extends StatefulWidget{
  _HomeState  createState()=> _HomeState();
}

class _HomeState extends State<Home>{
  List <PostData> postList = new List<PostData>();
  List <PostData> postList1 = new List<PostData>();
  @override
    void initState() {
    loadBannerData();
    loadBannerData1();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: new Refresh(
        onHeaderRefresh: loadBannerData,
        child: ListView.builder(
          // padding: kMaterialListPadding,
          itemCount: postList1.length + 1,
          itemBuilder: (BuildContext context,int index) {
            if(index == 0){
              if(postList.length > 0){
                return Container(
                height: 300.0,
                color: Colors.grey,
                child: HomeBanner(
                  banners: postList,
                  ),
                );
              }else{
                return Container(
                  height: 200.0,
                  color: Colors.grey,
                );
              }
            }else{
              final PostData item = postList1[index - 1];
              return buildDetailListRow(context, item);
            }
          },
        ),
      )
    );
  }


  Future<Null>  loadBannerData() async{
    var url = Api.FEED_URL + '福利/5/1';
    CategoryResponse categoryResponse = await Networking().getGankfromNet(url);
    return new Future.delayed(new Duration(seconds: 0), () {
      if (!categoryResponse.error) {
        var _listData = categoryResponse.results;
        if (_listData != null) {
          for (var value in _listData) {
          postList.add(PostData.fromJson(value));
          }
        }
        if (postList.length > 0) {
          setState(() {
          });
        }
      }
    });
  }
Future<Null>  loadBannerData1() async{
    postList1 = await Networking().fetchArticles();
    return new Future.delayed(new Duration(seconds: 0), () {
      if (postList1.length > 0) {
        setState(() {
        });
      }
    });
  }


  Widget buildDetailListRow(context, PostData postData) {
  return new InkWell(
      onTap: () {
        // routePagerNavigator(context, WebViewPage(postData.toJson()));
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Row(children: [
                new Container(
                  margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Icon(
                      Icons.access_time,
                      size: 12.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                new Text(
                  postData.publishedAt.toString(),
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    getTimestampString(DateTime.parse(postData.publishedAt)),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
              new Container(
                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    postData.desc,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              new Row(children: [
                new Text(
                  '作者:',
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Text(
                  postData.who.toString(),
                  style: new TextStyle(
                      fontSize: 12.0, color: Colors.green),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    postData.source.toString(),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
            ],
          ),
        ),
      ));
  }
  String getTimestampString(DateTime date) {
  DateTime curDate = new DateTime.now();
  Duration diff = curDate.difference(date);
  if (diff.inDays > 0) {
    return diff.inDays.toString() + "天前";
  } else if (diff.inHours > 0) {
    return diff.inHours.toString() + "小时前";
  } else if (diff.inMinutes > 0) {
    return diff.inMinutes.toString() + "分钟前";
  } else if (diff.inSeconds > 0) {
    return "刚刚";
  }
  return date.toString();
}
}