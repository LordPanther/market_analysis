import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/carousel.dart';
import '../widgets/destination_heading.dart';
import '../widgets/explore_drawer.dart';
import '../widgets/featured_heading.dart';
import '../widgets/featured_tiles.dart';
import '../widgets/floating_quick_access_bar.dart';
import '../widgets/responsive.dart';
import '../widgets/top_bar_contents.dart';
import '../widgets/web_scrollbar.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Text(
                'D J A V I S',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: SizedBox(
                      height: screenSize.height * 0.45,
                      width: screenSize.width,
                      child: Image.asset(
                        'assets/new_images/market.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Column(
                        children: [
                          FeaturedHeading(
                            screenSize: screenSize,
                          ),
                          FeaturedTiles(screenSize: screenSize)
                        ],
                      ),
                    ],
                  )
                ],
              ),
              DestinationHeading(screenSize: screenSize),
              DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              // BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
