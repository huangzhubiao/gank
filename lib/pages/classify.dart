import 'package:flutter/material.dart';
import '../pages/classify/ClassifyTabPage.dart';

class Classify extends StatefulWidget{
  _ClassifyState  createState()=> _ClassifyState();
}

class _ClassifyState extends State<Classify> with SingleTickerProviderStateMixin{
  TabController _controller;
  ClassifyTabPage classifyTabPage;
  List<ClassifyTabPage> classifyTab;

  @override
  void initState() {
    super.initState();
    classifyTabPage = new ClassifyTabPage();
    classifyTab = classifyTabPage.initClassify();
    _controller = new TabController(vsync: this, length: classifyTab.length);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TabBar(
          controller: _controller,
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          tabs: classifyTab.map((ClassifyTabPage page) {
            return new Tab(text: page.text);
          }).toList(),
        ),
      ),
      body: new TabBarView(
          controller: _controller,
          children: classifyTab.map((ClassifyTabPage page) {
            return page.detailPage;
          }).toList()),
    );
  }

}