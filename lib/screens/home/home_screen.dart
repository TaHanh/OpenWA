import 'package:flutter/material.dart';
import 'package:guide_ice_scream/config/env.dart';
import 'package:guide_ice_scream/main.dart';
import 'package:guide_ice_scream/screens/about/about_screen.dart';
import 'package:guide_ice_scream/screens/link/link_screen.dart';
import 'package:guide_ice_scream/screens/open_wa/open_wa_screen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AdmobInterstitial interstitialAd;
  // AdmobBannerSize bannerSize;
  String appId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final List<Widget> _children = [OpenWAScreen(), LinkScreen()];
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    getAppID();
  }

  void onTabTapped(int index) {
    print(_currentIndex);
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
    // if (interstitialAd != null) {
    //   interstitialAd.dispose();
    // }
  }

  @override
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getAppID() async {
    appId = await MyApp.platform.invokeMethod("getAppId");
    setState(() {
      appId;
    });
  }

  @override
  void callBack(key, data) {
    switch (key) {
      case "RATE":
        MyApp.platform.invokeMethod("rateManual");
        break;
      case "SHARE":
        String link = urlApp + appId;
        Share.share(link);
        break;
      case "FEEDBACK":
        launchURL("mailto:${mailFeedback}?subject=FeedBack ${nameApp}&body=");
        break;
      case "ABOUT":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutScreen()),
        );

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(nameApp),
        backgroundColor: Color(0xFF075e54),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[OpenWAScreen(), LinkScreen()],
        onPageChanged: (page) {},
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 50.0, 0, 30.0),
              decoration: BoxDecoration(
                color: Color(0xFF075e54),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      nameApp,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Share app'),
              leading: Icon(Icons.share),
              onTap: () {
                callBack("SHARE", "");
              },
            ),
            ListTile(
              title: Text('Rate app'),
              leading: Icon(Icons.star_border),
              onTap: () {
                callBack("RATE", "");
              },
            ),
            ListTile(
              title: Text('Feedback to us'),
              leading: Icon(Icons.feedback),
              onTap: () {
                callBack("FEEDBACK", "");
              },
            ),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.info_outline),
              onTap: () {
                callBack("ABOUT", "");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30.0,
        selectedItemColor: Color(0xFF075e54),
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.link),
            title: new Text(''),
          ),
        ],
      ),
    );
  }
}
