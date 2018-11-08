import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../model/PostData.dart';

class HomeBanner extends StatefulWidget {
  // final List<String> banners;
  final List<PostData> banners;

  const HomeBanner({Key key, this.banners}) : super(key: key);
  
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int sliderIndex = 0;
  bool runing = false;
  // List<String> banners;
  PageController controller;

  @override
  void initState() {
    controller = new PageController();
    super.initState();
    // banners = new List<String>();
    // banners.add('http://img05.tooopen.com/images/20150202/sy_80219211654.jpg');
    // banners.add('http://img06.tooopen.com/images/20161123/tooopen_sy_187628854311.jpg');
    // banners.add('http://img07.tooopen.com/images/20170306/tooopen_sy_200775896618.jpg');
    // banners.add('http://img06.tooopen.com/images/20170224/tooopen_sy_199503612842.jpg');
    // banners.add('http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg');
    // // run();
  }

  void run() async {
    this.runing = true;
    while (this.runing) {
      await Future<Null>.delayed(new Duration(seconds: 5));
      // await Future.delayed(new Duration(seconds: 5));
      if (mounted) {
        this.setState(() {
          this.sliderIndex = this.sliderIndex == widget.banners.length - 1
              ? 0
              : this.sliderIndex + 1;
          this.controller.animateToPage(
                this.sliderIndex,
                duration: new Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom:0.0),
      height: 10.0,
      width: MediaQuery.of(context).size.width,
      child: Swiper(
        itemBuilder:_swiperBuilder,
        itemCount: widget.banners.length,
        pagination: new SwiperPagination(
          builder:DotSwiperPaginationBuilder(
            color:Colors.black54,
            activeColor:Colors.white,
          )
        ),
        // control: new SwiperControl(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print("点击$index"),
      ),

    );
  }
  Widget _swiperBuilder(BuildContext context, int index) {

    PostData postdata = widget.banners[index];
    return (Image.network(
      postdata.url,
      fit: BoxFit.fill,
    ));
  }
}
