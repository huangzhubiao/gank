import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

//文章详情界面
// ignore: must_be_immutable
class ArticleDetailPage extends StatefulWidget {
  String title;
  String url;

  ArticleDetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ArticleDetailPageState();
  }
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isLoadind = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      debugPrint('state:_' + state.type.toString());
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          isLoadind = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoadind = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(widget.title),
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoadind
                ? new LinearProgressIndicator(
                    backgroundColor: Color(0xFFE57373),
                    valueColor: AlwaysStoppedAnimation(Color(0xFFD32F2F)))
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
