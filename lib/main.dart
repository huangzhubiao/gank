import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/classify.dart';
import './pages/home.dart';
import './pages/mine.dart';
import './pages/mine/MinePage.dart';


void main() {
  // final Store<ReduxState> store = StoreContainer.global;
  runApp(MyOSCClient());
}
class MyOSCClient extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new MyApp();
}

class MyApp extends State<MyOSCClient> {
  int _tabIndex = 0;
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = new TextStyle(color: Colors.blue);
  var tabImages;
  var _body;
  var appBarTitles = ['首页','分类','我的'];

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  void initData(){
    if(tabImages == null){
      tabImages = [
        [
          getTabImage('images/home_green.png'),
          getTabImage('images/home_green.png')
        ],
        [
          getTabImage('images/home_green.png'),
          getTabImage('images/home_green.png')
        ],
        [
          getTabImage('images/home_green.png'),
          getTabImage('images/home_green.png')
        ]
      ];
    }
    _body = new IndexedStack(
      children: <Widget>[
        new Home(),
        new Classify(),
        new MinePage()
      ],
      index: _tabIndex,
    );
  }
TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }
  
  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new Scaffold(
        body: _body,
        bottomNavigationBar: new CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0),
                title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1),
                title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2),
                title: getTabTitle(2))
          ],
          currentIndex: _tabIndex,
          onTap: (index){
            setState(() {
                          _tabIndex = index;
                        });
          },
        ),
      ),
    );
  }
}